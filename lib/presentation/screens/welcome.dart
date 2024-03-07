import 'package:flutter/material.dart';
import 'package:robotreparadorpixeles/presentation/screens/select_pantalla.dart';
import '../importaciones.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  //initializing intersticial ad
  InterstitialAd? interstitialAd;
  int interstitialAttempts = 0;

  Ads ads = Ads();

  //Creating interstitial
  //no used for the moment
/*   void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: ads.intersticial,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          interstitialAd = ad;
          interstitialAttempts = 0;
        }, onAdFailedToLoad: (error) {
          interstitialAttempts++;
          interstitialAd = null;
          print('failed to load ${error.message}');

          if (interstitialAttempts <= maxAttempts) {
            createInterstitialAd();
          }
        }));
  }

  //showing interstitial
  void showInterstitialAd() {
    if (interstitialAd == null) {
      //Toast diciendo: no se han podido cargar los anuncios.\n Asegurate de tener una buena conexión a internet, volver a abrir la App o intentar abrir el curso mas tarde, cuando los anuncios estén cargados en tu telefono.
      Fluttertoast.showToast(
        msg:
            "Tu telefono no ha cargado todos los componentes. Revisa tu conexión a internet\nIntentalo de nuevo en 3 segundos", // message
        toastLength: Toast.LENGTH_LONG, // length
        gravity: ToastGravity.CENTER, // location
      );

      print('trying to show before loading');
      return;
    }

    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) => print('ad showed $ad'),

        //when ad went closes
        onAdDismissedFullScreenContent: (ad) {
          //when ad closed, run this

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const HomeLcdScrenn()));
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          print('failed to show the ad $ad');

          createInterstitialAd();
        });

    interstitialAd!.show();
    interstitialAd = null;
  }
 */
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //load ads
    //createInterstitialAd();
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              Center(
                child: Container(
                  height: 250,
                  width: 350.0,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgQPf4exY3SR7fo7OeULIVgbSAJnWQ0aVbSCsre0LZzzdCYjT1R0xtto8fuF2C1haXsLe9zVZ5T7FVyU6WH2MRU4Bj41bR-xxKKwi55x_uJ2HA4aBq4lH4qM0o51y1R0dPPIciEiQgeqXVFDYN0NyC6ANUkvtFdUJhe42cOWdCZcuYQrt6meMqSTHQ/s320/banner%20logo%20app%20x500.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 1),
                child: Center(
                  child: Text("Repara: ",
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 63, 234, 69),
                          fontFamily: 'Silkscreen')),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 1),
                child: Text(
                    "- Toques fantasma.\n- Toques automáticos.\n- Pantalla loca. \n- Pixeles muertos.\n- Pantalla fantasma.",
                    style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 63, 234, 69),
                        fontFamily: 'Silkscreen')),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        const MaterialStatePropertyAll<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(
                          color: Colors.green,
                          width: 5.0,
                        ),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Comenzar',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Silkscreen'),
                  ),
                  onPressed: () {
                    //showDialogVerAd(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SelectPantalla()));
                  }),
            ],
          ),
        ),
      ),
    );
  }

/*   void showDialogVerAd(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              backgroundColor: Colors.white,
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Comenzar",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 25.0,
                          fontFamily: 'Silkscreen'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'El robot reparador de pixeles va a solucionar el problema con tu pantalla. Verás un corto anuncio para habilita la reparación',
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
                        'Aceptar e iniciar',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Silkscreen'),
                      ),
                      onPressed: () {
                        //Navigator.pop(context);

                        //interstitial ad

                        showInterstitialAd();
                      }),
                ),
              ]);
        });
  }
 */
  void shareApp() {
    Share.share("✅ Repara tu pantalla usando el robot reparador de pixeles."
        "\n\n- Toques fantasma.\n- Toques automáticos.\n- Pantalla loca. \n- Pixeles muertos.\n- Pantalla fantasma."
        "\n\nDescargar app: https://play.google.com/store/apps/details?id=com.appcursin.blogspot");
  }
}
