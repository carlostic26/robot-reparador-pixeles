import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/material.dart';
import '../importaciones.dart';

final Random randProgress = Random();

class ReparandoColorsAMOLED extends StatefulWidget {
  ReparandoColorsAMOLED({required this.duration, super.key});

  late int duration;

  @override
  State<ReparandoColorsAMOLED> createState() => _ReparandoColorsAMOLEDState();
}

class _ReparandoColorsAMOLEDState extends State<ReparandoColorsAMOLED> {
  Ads ads = Ads();

  //initializing intersticial ad
  InterstitialAd? interstitialAd;
  int interstitialAttempts = 0;

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  //Creating interstitial
  void createInterstitialAd() {
    InterstitialAd.load(
        // ignore: deprecated_member_use
        adUnitId: ads.interstitial,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          interstitialAd = ad;
          interstitialAttempts = 0;
        }, onAdFailedToLoad: (error) {
          interstitialAttempts++;
          interstitialAd = null;
          // print( '-------------------\n\n\n - failed to load interstitial:\n ${error.message}');

          if (interstitialAttempts <= maxAttempts) {
            createInterstitialAd();
          }
        }));
  }

  void showInterstitialAd() {
    interstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) async {
      //TODO: navegar a la siguiente pantalla

      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
    });

    interstitialAd!.show();
    interstitialAd = null;
  }

  late Timer timer;
  var color;
  bool _showText = true;

  //ads
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAdaptativeAd();
  }

  @override
  void dispose() {
    timer.cancel(); // Cancela el timer antes de descartar el estado
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadAdaptativeAd() async {
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    Ads ads = Ads();

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: ads.banner,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  Completer completer = Completer();

  int _start = 9000;

  void startTimerRetro() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start < 1) {
          timer.cancel();
        } else {
          _start--;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    createInterstitialAd();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    //_loadAdaptativeAd();
    _startTimerLoadingBar(30);
    changerColor();
    goBackHome();
    timerColor();
    // Configurar el timer para ocultar el texto después de 1 minuto
    ocultarAvisodeReparacion(30);

    Future.delayed(Duration(milliseconds: widget.duration * 60 * 500))
        .then((value) {
      completer.complete();
    });
  }

  void ocultarAvisodeReparacion(int seconds) {
    Timer(Duration(seconds: seconds), () {
      setState(() {
        _showText = false;
      });
    });
  }

  void timerColor() {
    timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      changerColor();
    });
  }

  void changerColor() {
    setState(() {
      color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    });
  }

  double _progressValue = 0.0;
  Timer? _timer;

  void _startTimerLoadingBar(int minutes) {
    const oneMinute = Duration(minutes: 1);
    final duration = Duration(minutes: minutes);
    int elapsedMinutes = 0;

    _timer = Timer.periodic(oneMinute, (timer) {
      setState(() {
        if (elapsedMinutes < minutes) {
          elapsedMinutes++;
          _progressValue = elapsedMinutes / minutes;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        interrupcion(context);
        return true;
      },
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh8al0JP35hhHlRLD8ybqf0Z0bDZP8lqiUVhBtVkklLAZM6si8ibtL2KMecBu1Vjq9_oLThyK5YovWvH2g0my1D5Z6GlunmGWJ1qIaKxe8zFIxFkrhSll8sdvbX9YmlzDwoZD8Pb06Wmvi3U5clvDjjL_9LdW4XhRbFhIV2MtT2kM3hTuWpxzxuD-BK/s16000/reparar%20AMOLED.gif",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: !completer.isCompleted,
                      child: SizedBox(
                        height: 100,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white
                                    .withOpacity(0.1), // Color de la sombra
                                spreadRadius: 8, // Extensión de la sombra
                                blurRadius: 10, // Suavizado de la sombra
                                offset:
                                    const Offset(0, 3), // Posición de la sombra
                              ),
                            ],
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://media1.giphy.com/media/ETUgqjnAV7AZUKbQMu/giphy.gif?cid=6c09b952lmopkynfrbd928kfzliidlqm39mjehwg0z9v60zb&rid=giphy.gif&ct=s',
                          ),
                        ),
                      )),

                  const SizedBox(
                    height: 10,
                  ),
                  _showText
                      ? Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Color de la sombra
                                spreadRadius: 8, // Extensión de la sombra
                                blurRadius: 10, // Suavizado de la sombra
                                offset:
                                    const Offset(0, 5), // Posición de la sombra
                              ),
                            ],
                          ),
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'REPARANDO...\n\nNo apague ni cierre la app.\nSe están reparando los pixeles.',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container(), // Muestra un contenedor vacío cuando _showText es falso

                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: !completer.isCompleted,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        //this row will center the LinearPercent
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LinearPercentIndicator(
                            width: 250.0,
                            lineHeight: 15,
                            percent: 100 / 100,
                            animation: true,
                            animationDuration: widget.duration * 60 * 700,
                            progressColor: Colors.black,
                          ),
                        ],
                      ),
                    ), // Ocultar el widget después de que se complete la animación.
                  ),
                ],
              ),
            ),

            //adaptative banner bottom screen
            bottomNavigationBar: _anchoredAdaptiveAd != null && _isLoaded
                ? Container(
                    color: Colors.transparent,
                    width: _anchoredAdaptiveAd!.size.width.toDouble(),
                    height: _anchoredAdaptiveAd!.size.height.toDouble(),
                    child: AdWidget(ad: _anchoredAdaptiveAd!),
                  )
                : Container(
                    color: Colors.transparent,
                    width: 320,
                    height: 50,
                    child: _isLoaded
                        ? AdWidget(ad: _anchoredAdaptiveAd!)
                        : const CircularProgressIndicator(
                            color: Colors.transparent,
                          ),
                  ),
          ),
        ],
      ),
    );
  }

  goBackHome() {
    Future.delayed(Duration(minutes: widget.duration), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeLcdScrenn()),
      );

      showDialogFinished(context);
    });
  }

  void interrupcion(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              backgroundColor: Colors.white,
              title: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Reparación interrumpida",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 25.0,
                          fontFamily: 'Silkscreen'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Espera el tiempo necesario antes de salir de la pantalla de reparación.',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontFamily: 'Silkscreen'),
                    ),
                  ]),
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 4, 75, 1)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 4, 75, 1),
                              width: 5.0,
                            ),
                          ),
                        ),
                      ),
                      child: const Text(
                        'De acuerdo',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Silkscreen'),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ]);
        });
  }

  void showDialogFinished(BuildContext context) {
    startTimerRetro();

    int hours = _start ~/ 3600;
    int minutes = (_start % 3600) ~/ 60;
    int seconds = _start % 60;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              backgroundColor: Colors.white,
              title: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "¡Listo!",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 25.0,
                          fontFamily: 'Silkscreen'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          'Hemos mejorado tu pantalla. Será necesario volver a usar el robot. Debes volver más tarde para realizar otro tiempo de reparación.\n\nPrueba tu pantalla y aumenta el tiempo de reparación si lo ves necesario.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontFamily: 'Silkscreen'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10, // Espacio antes del nuevo mensaje
                    ),
                    Center(
                      child: Text(
                        '¿Puedes apoyarnos viendo un anuncio?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontFamily: 'Silkscreen'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 4, 75, 1)),
                        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 4, 75, 1),
                              width: 5.0,
                            ),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Ok',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Silkscreen'),
                      ),
                      onPressed: () {
                        showInterstitialAd();
                        Navigator.pop(context);
                      }),
                ),
              ]);
        });
  }
}
