import 'package:flutter/material.dart';
import 'package:robotreparadorpixeles/presentation/screens/home_AMOLED.dart';
import 'package:robotreparadorpixeles/presentation/importaciones.dart';
import 'package:robotreparadorpixeles/presentation/screens/home_OLED.dart';
import 'package:robotreparadorpixeles/presentation/screens/select_fallo.dart';
import 'package:robotreparadorpixeles/presentation/screens/widgets/animated_background.dart';
import 'package:robotreparadorpixeles/presentation/screens/widgets/checkBox.dart';

class SelectPantalla extends StatefulWidget {
  const SelectPantalla({super.key});

  @override
  State<SelectPantalla> createState() => _SelectPantallaState();
}

const int maxAttempts = 3;

class _SelectPantallaState extends State<SelectPantalla> {
  bool _isLCDSelected = false;
  bool _isAMOLEDSelected = false;
  bool _isOLEDSelected = false;
  bool _isContinueEnabled = false;

  final List<bool> _checkboxValues = List.filled(
      6, false); // Mantén un estado separado para cada casilla de verificación

  Ads ads = Ads();

  //initializing intersticial ad
  InterstitialAd? interstitialAd;
  int interstitialAttempts = 0;
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

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

  @override
  void initState() {
    super.initState();
    createInterstitialAd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAdaptativeAd();
    _loadAdaptativeAd();
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

    setState(() {});

    Ads ads = Ads();

    _anchoredAdaptiveAd = BannerAd(
      // TODO: replace these test ad units with your own ad unit.
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        children: [
          AnimatedBackground(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBar(
                  centerTitle: true,
                  backgroundColor: const Color.fromARGB(30, 0, 0, 0),
                  title: const Text(
                    'Tipo de pantalla',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SelectFallo()),
                      );
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.info),
                        onPressed: () {
                          showAppInfo(context);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.1),
                        MyCheckBox(
                          text: 'LCD (IPS,TFT)',
                          onPressed: (isChecked) {
                            setState(() {
                              _isLCDSelected = isChecked;
                              _isContinueEnabled = _isLCDSelected ||
                                  _isAMOLEDSelected ||
                                  _isOLEDSelected;
                            });
                          },
                        ),
                        SizedBox(height: height * 0.01),
                        MyCheckBox(
                          text: 'AMOLED',
                          onPressed: (isChecked) {
                            setState(() {
                              _isAMOLEDSelected = isChecked;
                              _isContinueEnabled = _isLCDSelected ||
                                  _isAMOLEDSelected ||
                                  _isOLEDSelected;
                            });
                          },
                        ),
                        SizedBox(height: height * 0.01),
                        MyCheckBox(
                          text: 'OLED',
                          onPressed: (isChecked) {
                            setState(() {
                              _isOLEDSelected = isChecked;
                              _isContinueEnabled = _isLCDSelected ||
                                  _isAMOLEDSelected ||
                                  _isOLEDSelected;
                            });
                          },
                        ),
                        SizedBox(height: height * 0.05),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          '¿No sabes que pantalla tienes?',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Silkscreen',
                          ),
                        ),
                        const Text(
                          'Revisa tutorial en YouTube',
                          style: TextStyle(
                            fontSize: 9.0,
                            color: Colors.grey,
                            fontFamily: 'Silkscreen',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    'https://i.ytimg.com/vi/HPIl4K2VRbQ/maxresdefault.jpg',
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.99),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: _launchYouTubeVideo,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(187, 130, 130, 130),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isContinueEnabled
            ? () {
                if (_isLCDSelected) {
                  GoLCD();
                } else if (_isAMOLEDSelected) {
                  GoAMOLED();
                } else if (_isOLEDSelected) {
                  GoOLED();
                }
                showInterstitialAd();
              }
            : null,
        label: Text(
          'Continuar',
          style: TextStyle(
              color: _isContinueEnabled ? Colors.white : Colors.black54),
        ),
        backgroundColor:
            _isContinueEnabled ? Colors.grey : Colors.grey.withOpacity(0.5),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _anchoredAdaptiveAd != null && _isLoaded
          ? Container(
              color: const Color.fromARGB(0, 55, 77, 56),
              width: _anchoredAdaptiveAd!.size.width.toDouble(),
              height: _anchoredAdaptiveAd!.size.height.toDouble(),
              child: AdWidget(ad: _anchoredAdaptiveAd!),
            )
          : Container(),
    );
  }

  void showAppInfo(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Información",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18.0,
                        fontFamily: 'Silkscreen'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
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
                        'Política de privacidad',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontFamily: 'Silkscreen'),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        launch(
                            'https://robotpixeles.blogspot.com/2022/10/politicas-de-privacidad-de-robot.html');
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
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
                        'Compartir app',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontFamily: 'Silkscreen'),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        shareApp();
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
          );
        });
  }

  void shareApp() {
    Share.share("✅ Repara tu pantalla usando el robot reparador de pixeles."
        "\n\n- Toques fantasma.\n- Toques automáticos.\n- Pantalla loca. \n- Pixeles muertos.\n- Pantalla fantasma."
        "\n\nDescargar app: https://play.google.com/store/apps/details?id=com.robotpixeles.blogspot");
  }

  void _launchYouTubeVideo() async {
    const url = 'https://youtu.be/HPIl4K2VRbQ';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
        msg: "Busca en YouTube: TICnoticos tipo de pantalla",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      throw 'No se pudo abrir el enlace: $url';
    }
  }

  void GoLCD() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HomeLcdScrenn()));
  }

  void GoAMOLED() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HomeAmoledScrenn()));
  }

  void GoOLED() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HomeOledScrenn()));
  }
}
