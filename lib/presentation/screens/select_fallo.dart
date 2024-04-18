import 'package:flutter/material.dart';
import 'package:robotreparadorpixeles/presentation/screens/home_AMOLED.dart';
import 'package:robotreparadorpixeles/presentation/importaciones.dart';
import 'package:robotreparadorpixeles/presentation/screens/select_pantalla.dart';
import 'package:robotreparadorpixeles/presentation/screens/widgets/animated_background.dart';

class SelectFallo extends StatefulWidget {
  const SelectFallo({Key? key}) : super(key: key);

  @override
  State<SelectFallo> createState() => _SelectFalloState();
}

class _SelectFalloState extends State<SelectFallo> {
  bool _isContinueEnabled = false;

  //ads
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;

  List<bool> _checkboxValues = List.filled(
      6, false); // Mantén un estado separado para cada casilla de verificación

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAdaptativeAd();
    });
  }

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

    setState(() {});

    Ads ads = Ads();

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: ads.banner,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded =
                true; // Cambiar a true cuando el anuncio se carga correctamente
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
          setState(() {
            _isLoaded = false; // Cambiar a false si el anuncio falla al cargar
          });
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                centerTitle: true,
                backgroundColor: const Color.fromARGB(30, 0, 0, 0),
                title: const Text(
                  'Seleccionar tipos de falla',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
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
              const SizedBox(
                height: 100,
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
                      CheckboxListTile(
                        activeColor: Colors.grey,
                        checkColor: Colors.white,
                        title: const Text(
                          'Pantalla fantasma',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        value: _checkboxValues[0],
                        onChanged: (value) {
                          setState(() {
                            _checkboxValues[0] = value!;
                            _isContinueEnabled = true;
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Colors.grey,
                        checkColor: Colors.white,
                        title: const Text(
                          'Pantalla loca',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        value: _checkboxValues[
                            1], // Usar la segunda variable de estado
                        onChanged: (value) {
                          setState(() {
                            _checkboxValues[1] = value!;
                            _isContinueEnabled = true;
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Colors.grey,
                        checkColor: Colors.white,
                        title: const Text(
                          'Pantalla con lineas',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        value: _checkboxValues[
                            2], // Usar la tercera variable de estado
                        onChanged: (value) {
                          setState(() {
                            _checkboxValues[2] = value!;
                            _isContinueEnabled = true;
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Colors.grey,
                        checkColor: Colors.white,
                        title: const Text(
                          'Pantalla Quemada',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        value: _checkboxValues[
                            3], // Usar la cuarta variable de estado
                        onChanged: (value) {
                          setState(() {
                            _checkboxValues[3] = value!;
                            _isContinueEnabled = true;
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Colors.grey,
                        checkColor: Colors.white,
                        title: const Text(
                          'Pantalla opaca',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        value: _checkboxValues[
                            4], // Usar la quinta variable de estado
                        onChanged: (value) {
                          setState(() {
                            _checkboxValues[4] = value!;
                            _isContinueEnabled = true;
                          });
                        },
                      ),
                      CheckboxListTile(
                        activeColor: Colors.grey,
                        checkColor: Colors.white,
                        title: const Text(
                          'Otro',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        value: _checkboxValues[
                            5], // Usar la sexta variable de estado
                        onChanged: (value) {
                          setState(() {
                            _checkboxValues[5] = value!;
                            _isContinueEnabled = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isAnyCheckboxChecked()
            ? () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const SelectPantalla()));
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

  // Método para verificar si al menos una casilla de verificación está marcada
  bool _isAnyCheckboxChecked() {
    return _checkboxValues.any((element) => element);
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
