import 'dart:async';
import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:robotreparadorpixeles/screens/home_screen.dart';

final Random randProgress = Random();

class ColorsScreen extends StatefulWidget {
  ColorsScreen({required this.SecondsTimer, super.key});

  late int SecondsTimer;

  @override
  State<ColorsScreen> createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
  late Timer timer;
  var color;

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
  void initState() {
    super.initState();
    var color =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    changerColor();
    goBackHome();
    timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      changerColor();
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancela el timer antes de descartar el estado
    super.dispose();
  }

  void changerColor() {
    setState(() {
      color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print(" no go back until repair finish");

        interrupcion(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: color,

        appBar: AppBar(
          backgroundColor: Colors.transparent, // Fondo transparente
          elevation: 0, // Sin sombra
          toolbarHeight: 700, // Altura personalizada
          iconTheme: const IconThemeData(
              color: Colors.transparent), // Color de ícono transparente

          title: const Align(
            alignment: Alignment.center,
            child: Text(
              'REPARANDO...\n\nNo apague ni cierre la app.\nSe están reparando los pixeles.',
              style: TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        //ad banner bottom screen
        bottomNavigationBar: Container(
          color: const Color.fromARGB(0, 72, 71, 71),
          //height: 60,
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

/*   changerColor() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0);
      });
    });

    return color;
  } */

  goBackHome() {
    Future.delayed(Duration(seconds: widget.SecondsTimer), () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const HomeScrenn()),
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
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
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
                      "Listo!",
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
                        padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                        child: Text(
                          'El robot reparador de pixeles ha mejorado el desempeño. \n\nPrueba tu pantalla y vuelve a aumentar el tiempo si no estás satisfecho.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontFamily: 'Silkscreen'),
                        ),
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
                        'Ok',
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
}
