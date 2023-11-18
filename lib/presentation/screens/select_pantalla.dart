import 'package:flutter/material.dart';
import 'package:robotreparadorpixeles/presentation/screens/home_AMOLED.dart';
import 'package:robotreparadorpixeles/presentation/importaciones.dart';

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
/*         appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'Tipo de pantalla',
            style: TextStyle(
              fontSize: 12.0, /*fontWeight: FontWeight.bold*/
            ),
          ),
          centerTitle: true,
        ), */
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Seleccionar tipo de pantalla',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontFamily: 'Silkscreen'),
                ),
                const SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                  onPressed: () {
                    GoLCD();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green, width: 2),
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
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green, width: 2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('AMOLED - OLED'),
                ),
                const SizedBox(
                  height: 120,
                ),
                const Text(
                  '¿No sabes que pantalla tienes?',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.green,
                      fontFamily: 'Silkscreen'),
                ),
                const Text(
                  'Revisa este tutorial',
                  style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                      fontFamily: 'Silkscreen'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 5, 50, 0),
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
              ],
            ),
          ),
        ));
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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const HomeLcdScrenn()));
  }

  void GoAMOLED() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HomeAmoledScrenn()));
  }
}
