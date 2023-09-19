import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:robotreparadorpixeles/ads/ads.dart';
import 'package:robotreparadorpixeles/screens/colors_screen.dart';
import 'package:robotreparadorpixeles/screens/welcome_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScrenn extends StatefulWidget {
  const HomeScrenn({super.key});

  @override
  State<HomeScrenn> createState() => _HomeScrennState();
}

const int maxAttempts = 3;

class _HomeScrennState extends State<HomeScrenn> {
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
    // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
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
  void initState() {
    // TODO: implement initState
    //_loadAdaptativeAd();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const WelcomeScreen()));

        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'Tu Robot Reparador de Pantalla',
            style: TextStyle(
              fontSize: 12.0, /*fontWeight: FontWeight.bold*/
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  //dialog to go privacy politicies
                  showAppInfo(context);
                },
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 230,
                    width: 200.0,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://blogger.googleusercontent.com/img/a/AVvXsEjmvYzgxViZXfwH1MRQhiS8whSx9GbjVku1Djh8xh4qmbm-pdfND-1wB2ZhelNexTJkUkcN2eUy72WTK1T4Sm9LqcAXzRwJMVbXtCsV4Ql_Vf3bofYWRwK4Ef0h7CGi9WnQV020ry9loBXCNlcOXR1ISx4N2POBC0mBokxzZLksWjzegSIIR2lBLUs',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 10, 1),
                        child: Center(
                          child: Text("Repara",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 63, 234, 69),
                                  fontFamily: 'Silkscreen')),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                        child: Text(
                            "- Pixeles muertos.\n- Pantalla fantasma.\n- Manchas en pantalla.\n- Lineas blancas.",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontFamily: 'Silkscreen')),
                      ),
                    ],
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 1),
                          child: Center(
                            child: Text("Recuerde",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Color.fromARGB(255, 63, 234, 69),
                                    fontFamily: 'Silkscreen')),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 30, 10),
                          child: Text(
                              "1. Ajustar tiempo de pantalla en el máximo posible.\n2. Ajustar brillo inferior al 60%\n3. Verificar que la pantalla no esté levantada.\n4. Verificar que la pantalla no esté mojada.\n5. No usar el telefono mientras esté cargando.\n6. Usar tiempos necesarios según el daño.\n7. Repetir reparación durante al menos una semana.",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontFamily: 'Silkscreen')),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Text(
                    "Recuerde configurar en su teléfono el tiempo activo de su pantalla en el máximo posible.\n\nSu pantalla no deberá apagarse para que la rapación no se interrumpa.",
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.blueGrey,
                        fontFamily: 'Silkscreen')),
              ),
              const SizedBox(
                height: 70,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          '5 min',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Silkscreen',
                              fontSize: 10),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.build_circle,
                            color: Colors.blueGrey,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ColorsScreen(
                                        SecondsTimer: 300,
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        const Text('10 min',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Silkscreen',
                                fontSize: 10)),
                        IconButton(
                          icon: const Icon(
                            Icons.build_circle,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ColorsScreen(
                                        SecondsTimer: 600,
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        const Text('30 min',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Silkscreen',
                                fontSize: 10)),
                        IconButton(
                          icon: const Icon(
                            Icons.build_circle,
                            color: Colors.red,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ColorsScreen(
                                        SecondsTimer: 1800,
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        const Text('1 hora',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Silkscreen',
                                fontSize: 10)),
                        IconButton(
                          icon: const Icon(
                            Icons.build_circle,
                            color: Colors.amber,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ColorsScreen(
                                        SecondsTimer: 3600,
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        const Text('3 horas',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Silkscreen',
                                fontSize: 10)),
                        IconButton(
                          icon: const Icon(
                            Icons.build_circle,
                            color: Colors.blue,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ColorsScreen(
                                        SecondsTimer: 10800,
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        const Text('5 horas',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Silkscreen',
                                fontSize: 10)),
                        IconButton(
                          icon: const Icon(
                            Icons.build_circle,
                            color: Colors.green,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ColorsScreen(
                                        SecondsTimer: 18000,
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
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
            : Container(
                color: const Color.fromARGB(0, 55, 77, 56),
                width:
                    320, // Establece un ancho predeterminado cuando el anuncio no está cargado
                height:
                    50, // Establece un alto predeterminado cuando el anuncio no está cargado
                child: _isLoaded
                    ? AdWidget(
                        ad: _anchoredAdaptiveAd!) // Muestra el anuncio cuando está cargado
                    : const CircularProgressIndicator(
                        color: Colors.transparent,
                      ),
              ),
      ),
    );
  }

  void shareApp() {
    Share.share("✅ Repara tu pantalla usando el robot reparador de pixeles."
        "\n\n- Toques fantasma.\n- Toques automáticos.\n- Pantalla loca. \n- Pixeles muertos.\n- Pantalla fantasma."
        "\n\nDescargar app: https://play.google.com/store/apps/details?id=com.robotpixeles.blogspot");
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
}
