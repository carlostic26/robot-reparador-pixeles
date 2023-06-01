import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
  BannerAd? bannerAd;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    bannerAd = BannerAd(
      size: AdSize.banner,
      //test: ca-app-pub-3940256099942544/6300978111 || Real: ca-app-pub-4336409771912215/9135934709

      adUnitId: "ca-app-pub-4336409771912215/9135934709",
      listener: BannerAdListener(onAdLoaded: (ad) {
        setState(() {
          isLoaded = true;
        });
        print('Banner ad loaded');
      }, onAdFailedToLoad: (ad, error) {
        ad.dispose();
        print('ad failed to load ${error.message}');
      }),
      request: const AdRequest(),
    );

    bannerAd!.load();
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
                padding: EdgeInsets.fromLTRB(10, 10, 10, 1),
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
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      Colors.green),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 20, 76, 22),
                                    width: 5.0,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Reparar 🛠️',
                              style: TextStyle(
                                  fontFamily: 'Silkscreen',
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ColorsScreen(
                                          SecondsTimer: 300,
                                        )),
                              );
                            }),
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
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      Colors.green),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 20, 76, 22),
                                    width: 5.0,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Reparar 🛠️',
                              style: TextStyle(
                                  fontFamily: 'Silkscreen',
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                //enviar a shared prferences el tiempo a reparar
                                MaterialPageRoute(
                                    builder: (context) => ColorsScreen(
                                          SecondsTimer: 600,
                                        )),
                              );
                            }),
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
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      Colors.green),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 20, 76, 22),
                                    width: 5.0,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Reparar 🛠️',
                              style: TextStyle(
                                  fontFamily: 'Silkscreen',
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ColorsScreen(
                                          SecondsTimer: 1800,
                                        )),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      Colors.green),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 20, 76, 22),
                                    width: 5.0,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Reparar 🛠️',
                              style: TextStyle(
                                  fontFamily: 'Silkscreen',
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ColorsScreen(
                                          SecondsTimer: 3600,
                                        )),
                              );
                            }),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        const Text('3 horas',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Silkscreen',
                                fontSize: 10)),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      Colors.green),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 20, 76, 22),
                                    width: 5.0,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Reparar 🛠️',
                              style: TextStyle(
                                  fontFamily: 'Silkscreen',
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ColorsScreen(
                                          SecondsTimer: 10800,
                                        )),
                              );
                            }),
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
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  const MaterialStatePropertyAll<Color>(
                                      Colors.green),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 20, 76, 22),
                                    width: 5.0,
                                  ),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Reparar 🛠️',
                              style: TextStyle(
                                  fontFamily: 'Silkscreen',
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => ColorsScreen(
                                          SecondsTimer: 18000,
                                        )),
                              );
                            }),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),

        //ad banner bottom screen
        bottomNavigationBar: Container(
          height: 60,
          child: Center(
            child: Column(
              children: [
                isLoaded
                    ? Container(
                        width: bannerAd!.size.width.toDouble(),
                        height: bannerAd!.size.height.toDouble(),
                        alignment: Alignment.bottomCenter,
                        child: AdWidget(
                          ad: bannerAd!,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
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
}
