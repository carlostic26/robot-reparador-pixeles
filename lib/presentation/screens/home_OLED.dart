import 'package:flutter/material.dart';
import 'package:robotreparadorpixeles/presentation/importaciones.dart';
import 'package:robotreparadorpixeles/presentation/screens/reparando_AMOLED.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeOledScrenn extends StatefulWidget {
  const HomeOledScrenn({super.key});

  @override
  State<HomeOledScrenn> createState() => _HomeOledScrennState();
}

const int maxAttempts = 3;

class _HomeOledScrennState extends State<HomeOledScrenn> {
  //ads
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  AnchoredAdaptiveBannerAdSize? _adSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAdaptativeAd();
  }

  Future<void> _loadAdaptativeAd() async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    setState(() {
      _adSize = size;
    });

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

  @override
  void initState() {
    super.initState();
    _loadAdaptativeAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Pantalla OLED',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (await canLaunch('https://youtu.be/XosdL2MuUNk')) {
                    launch('https://youtu.be/XosdL2MuUNk');
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  disabledForegroundColor: Colors.transparent,
                  disabledBackgroundColor: Colors.transparent,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.youtube,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const Expanded(
                child: Text(
                  'Tutorial',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              ),
            ],
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 25, 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Recuerde',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Silkscreen',
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1. Ajustar tiempo de pantalla en el máximo posible.",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              Text(
                                "2. Ajustar brillo inferior al 60%",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              Text(
                                "3. Verificar que la pantalla no esté levantada.",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              Text(
                                "4. Verificar que la pantalla no esté mojada.",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              Text(
                                "5. No usar el telefono mientras esté cargando.",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              Text(
                                "6. Usar tiempos necesarios según el daño.",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              Text(
                                "7. Repetir reparación 3 veces por semana.",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              width: 1,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh8al0JP35hhHlRLD8ybqf0Z0bDZP8lqiUVhBtVkklLAZM6si8ibtL2KMecBu1Vjq9_oLThyK5YovWvH2g0my1D5Z6GlunmGWJ1qIaKxe8zFIxFkrhSll8sdvbX9YmlzDwoZD8Pb06Wmvi3U5clvDjjL_9LdW4XhRbFhIV2MtT2kM3hTuWpxzxuD-BK/s16000/reparar%20AMOLED.gif",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //const Divider(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Tiempos',
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Silkscreen'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.build_circle,
                                color: Colors.blueGrey,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReparandoColorsAMOLED(
                                            duration: 11,
                                          )),
                                );
                              },
                            ),
                            const Text(
                              '10 min',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Silkscreen',
                                  fontSize: 10),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.build_circle,
                                color: Colors.white,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReparandoColorsAMOLED(
                                            duration: 22,
                                          )),
                                );
                              },
                            ),
                            const Text('20 min',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Silkscreen',
                                    fontSize: 10)),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.build_circle,
                                color: Colors.red,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReparandoColorsAMOLED(
                                            duration: 45,
                                          )),
                                );
                              },
                            ),
                            const Text('40 min',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Silkscreen',
                                    fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.build_circle,
                                color: Colors.amber,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReparandoColorsAMOLED(
                                            duration: 60,
                                          )),
                                );
                              },
                            ),
                            const Text('1 hora',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Silkscreen',
                                    fontSize: 10)),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.build_circle,
                                color: Colors.blue,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReparandoColorsAMOLED(
                                            duration: 180,
                                          )),
                                );
                              },
                            ),
                            const Text('3 horas',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Silkscreen',
                                    fontSize: 10)),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.build_circle,
                                color: Colors.green,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReparandoColorsAMOLED(
                                            duration: 360,
                                          )),
                                );
                              },
                            ),
                            const Text('5 horas',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Silkscreen',
                                    fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //const Divider(),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 25, 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      textAlign: TextAlign.center,
                      '¿No sabes configurar el tiempo maximo de pantalla?',
                      style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 10.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Silkscreen'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Revisa el tutorial en YouTube',
                      style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.grey,
                          fontFamily: 'Silkscreen'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                'https://i.ytimg.com/vi/qNIgr-gLTw0/maxresdefault.jpg',
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
                            onTap: _launchConfPantallaVideo,
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
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      //adaptative banner bottom screen
      bottomNavigationBar: _anchoredAdaptiveAd != null && _isLoaded
          ? Container(
              color: const Color.fromARGB(0, 55, 77, 56),
              width: _anchoredAdaptiveAd!.size.width.toDouble(),
              height: _anchoredAdaptiveAd!.size.height.toDouble(),
              child: AdWidget(ad: _anchoredAdaptiveAd!),
            )
          : const SizedBox.shrink(),
    );
  }

  void _launchYouTubeVideo() async {
    const url = 'https://youtu.be/XosdL2MuUNk';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
        msg: "Busca en YouTube: TICnoticos reparar pantalla",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      throw 'No se pudo abrir el enlace: $url';
    }
  }

  void _launchConfPantallaVideo() async {
    const url = 'https://youtu.be/qNIgr-gLTw0';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(
        msg: "Busca en YouTube: TICnoticos reparar pantalla",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
      throw 'No se pudo abrir el enlace: $url';
    }
  }
}
