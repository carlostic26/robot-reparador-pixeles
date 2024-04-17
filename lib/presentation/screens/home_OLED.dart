import 'package:flutter/material.dart';
import 'package:robotreparadorpixeles/presentation/importaciones.dart';
import 'package:robotreparadorpixeles/presentation/screens/reparando_AMOLED.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeOledScrenn extends StatefulWidget {
  const HomeOledScrenn({super.key});

  @override
  State<HomeOledScrenn> createState() => _HomeAmoledScrennState();
}

const int maxAttempts = 3;

class _HomeAmoledScrennState extends State<HomeOledScrenn> {
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
    super.initState();
    _loadAdaptativeAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppBar(
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
                  icon: const Icon(Icons.arrow_back)),
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
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 30, 10),
                        child: Text(
                            "1. Ajustar tiempo de pantalla en el máximo posible.\n2. Ajustar brillo inferior al 60%\n3. Verificar que la pantalla no esté levantada.\n4. Verificar que la pantalla no esté mojada.\n5. No usar el telefono mientras esté cargando.\n6. Usar tiempos necesarios según el daño.\n7. Repetir reparación 3 veces por semana.",
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
                  "Recuerde configurar el tiempo activo de su pantalla en el máximo posible.\n\nSu pantalla no deberá apagarse para que la rapación no se interrumpa.",
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.blueGrey,
                      fontFamily: 'Silkscreen')),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 2,
              width: 2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEh8al0JP35hhHlRLD8ybqf0Z0bDZP8lqiUVhBtVkklLAZM6si8ibtL2KMecBu1Vjq9_oLThyK5YovWvH2g0my1D5Z6GlunmGWJ1qIaKxe8zFIxFkrhSll8sdvbX9YmlzDwoZD8Pb06Wmvi3U5clvDjjL_9LdW4XhRbFhIV2MtT2kM3hTuWpxzxuD-BK/s16000/reparar%20AMOLED.gif",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      '10 min',
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
                              builder: (context) => ReparandoColorsAMOLED(
                                    duration: 11,
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
                    const Text('20 min',
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
                              builder: (context) => ReparandoColorsAMOLED(
                                    duration: 22,
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
                    const Text('40 min',
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
                              builder: (context) => ReparandoColorsAMOLED(
                                    duration: 45,
                                  )),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
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
                              builder: (context) => ReparandoColorsAMOLED(
                                    duration: 60,
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
                              builder: (context) => ReparandoColorsAMOLED(
                                    duration: 180,
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
                    const Text('6 horas',
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
                              builder: (context) => ReparandoColorsAMOLED(
                                    duration: 360,
                                  )),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '¿No sabes como configurar el tiempo',
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Silkscreen'),
                ),
                const Text(
                  'maximo de pantalla?',
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
                  padding: const EdgeInsets.fromLTRB(100, 5, 100, 0),
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
          ],
        ),
      ),

//adaptative banner bottom screen
      bottomNavigationBar: _anchoredAdaptiveAd != null && _isLoaded
          ? Container(
              color: Colors.transparent,
              width: _anchoredAdaptiveAd!.size.width.toDouble(),
              height: _anchoredAdaptiveAd!.size.height.toDouble(),
              child: AdWidget(ad: _anchoredAdaptiveAd!),
            )
          : Container(
              color: Colors.transparent,
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
