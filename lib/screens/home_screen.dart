import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:robotreparadorpixeles/ads.dart';
import 'package:robotreparadorpixeles/screens/colors_screen.dart';
import 'package:robotreparadorpixeles/screens/welcome_screen.dart';
import 'package:share_plus/share_plus.dart';

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
                icon: const Icon(Icons.share_outlined),
                onPressed: () {
                  shareApp();
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
              Container(
                height: 230,
                width: 200.0,
                child: Image.network(
                  'https://blogger.googleusercontent.com/img/a/AVvXsEjmvYzgxViZXfwH1MRQhiS8whSx9GbjVku1Djh8xh4qmbm-pdfND-1wB2ZhelNexTJkUkcN2eUy72WTK1T4Sm9LqcAXzRwJMVbXtCsV4Ql_Vf3bofYWRwK4Ef0h7CGi9WnQV020ry9loBXCNlcOXR1ISx4N2POBC0mBokxzZLksWjzegSIIR2lBLUs',
                  fit: BoxFit.contain,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 1),
                child: Center(
                  child: Text("Repara: ",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 63, 234, 69),
                          fontFamily: 'Silkscreen')),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                    "- Toques fantasma.\n- Toques automáticos.\n- Pantalla loca. \n- Pixeles muertos.\n- Pantalla fantasma.",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 63, 234, 69),
                        fontFamily: 'Silkscreen')),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Text(
                    "Recuerde configurar en su teléfono el tiempo ativo de su pantalla en el máximo posible.\n\nSu pantalla no deberá apagarse.",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'Silkscreen')),
              ),
              const SizedBox(
                height: 50,
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
                          '5 minutos',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Silkscreen',
                              fontSize: 10),
                        ),
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
                                        SecondsTimer: 300,
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        const Text('10 minutos',
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
                                        SecondsTimer: 600,
                                      )),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        const Text('30 minutos',
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
                            color: Colors.green,
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
                      width: 15,
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
                            color: Colors.green,
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
                      width: 10,
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
                color: const Color.fromARGB(
                    0, 55, 77, 56), // Aquí se establece el color del Container
                width: _anchoredAdaptiveAd!.size.width.toDouble(),
                height: _anchoredAdaptiveAd!.size.height.toDouble(),
                child: AdWidget(ad: _anchoredAdaptiveAd!),
              ),
      ),
    );
  }

  void shareApp() {
    Share.share("✅ Repara tu pantalla usando el robot reparador de pixeles."
        "\n\n- Toques fantasma.\n- Toques automáticos.\n- Pantalla loca. \n- Pixeles muertos.\n- Pantalla fantasma."
        "\n\nDescargar app: https://play.google.com/store/apps/details?id=com.robotpixeles.blogspot");
  }
}
