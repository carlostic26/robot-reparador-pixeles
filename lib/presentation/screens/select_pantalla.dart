import 'package:flutter/material.dart';
import 'package:robotreparadorpixeles/presentation/screens/home_AMOLED.dart';
import 'package:robotreparadorpixeles/presentation/importaciones.dart';

import 'widgets/animated_background.dart';

class SelectPantalla extends StatefulWidget {
  const SelectPantalla({super.key});

  @override
  State<SelectPantalla> createState() => _SelectPantallaState();
}

class _SelectPantallaState extends State<SelectPantalla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Reparar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0, /*fontWeight: FontWeight.bold*/
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.info),
                onPressed: () {
                  //dialog to go privacy politicies
                  showAppInfo(context);
                },
              ),
            ),
          ],
        ),
        body: Stack(children: [
          //AnimatedBackground(),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Center(
                      child: SizedBox(
                        height: 100,
                        width: 150.0,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgQPf4exY3SR7fo7OeULIVgbSAJnWQ0aVbSCsre0LZzzdCYjT1R0xtto8fuF2C1haXsLe9zVZ5T7FVyU6WH2MRU4Bj41bR-xxKKwi55x_uJ2HA4aBq4lH4qM0o51y1R0dPPIciEiQgeqXVFDYN0NyC6ANUkvtFdUJhe42cOWdCZcuYQrt6meMqSTHQ/s320/banner%20logo%20app%20x500.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 10, 1),
                          child: Text(
                              "- Toques fantasma.\n- Toques automáticos.\n- Pantalla loca. \n- Pixeles muertos.\n- Pantalla fantasma.",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontFamily: 'Silkscreen')),
                        ),
                      ],
                    ),
                  ]),
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Elegir tipo de pantalla',
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromARGB(255, 63, 234, 69),
                        fontFamily: 'Silkscreen'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      GoLCD();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      side: const BorderSide(color: Colors.grey, width: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('IPS LCD - TFT'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      GoAMOLED();
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      side: const BorderSide(color: Colors.grey, width: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text('AMOLED - OLED'),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    '¿No sabes que pantalla tienes?',
                    style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.green,
                        fontFamily: 'Silkscreen'),
                  ),
                  const Text(
                    'Revisa el tutorial en YouTube',
                    style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                        fontFamily: 'Silkscreen'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 5, 60, 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Imagen de fondo
                        CachedNetworkImage(
                          imageUrl:
                              'https://i.ytimg.com/vi/HPIl4K2VRbQ/maxresdefault.jpg',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),

                        // Degradado que ocupa la imagen
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withOpacity(0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Botón de reproducción
                        InkWell(
                          onTap: _launchYouTubeVideo,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(187, 130, 130, 130),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(16),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
          ),
        ]));
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
}
