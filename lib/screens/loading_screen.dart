import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:robotreparadorpixeles/screens/welcome_screen.dart';

// ignore: camel_case_types
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

// ignore: camel_case_types
class _LoadingScreenState extends State<LoadingScreen> {
  bool _isFirstBuild = true;
  bool? contadorFinalizado = false;
  bool isButtonVisible =
      false; // Nuevo estado para controlar la visibilidad del botón
  bool _buttonEnabled = false;

  @override
  // ignore: must_call_super
  void initState() {
    //despues de 9 segundos se habilita boton
    Future.delayed(const Duration(seconds: 9), () {
      _isFirstBuild =
          false; // Establecer en false después de la primera construcción
      setState(() {
        _buttonEnabled = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Image.network(
                'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgHBfFRTy1XLSopVeA1w9cAjRICacYdQIosMTut7i9BpmKWi0_GU3x4urvCjF27uENJzW7Y_uopy6s557quBbvh9x4Cd6SwLlW28-Eyu7IvLGqe8x_DXotvRBj7D7EAOIXIHKBlBG96XO4VpY7oYHgxqmw66wS8FH6GTxg87owY5GaJ34UJHDWi2bw/s320/icon%20700x700.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearPercentIndicator(
                    width: 250.0,
                    lineHeight: 15,
                    percent: 100 / 100,
                    animation: true,
                    animationDuration: 9000, //7 sec to load bar
                    progressColor: Colors.green,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Cargando Robot reparador de pixeles",
                    style: TextStyle(
                        fontSize: 10,
                        //fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                child: TextButton(
                  onPressed: _buttonEnabled
                      ? () async {
                          isLoaded();
                        }
                      : null, // Desactiva el botón si no está habilitado
                  style: ButtonStyle(
                    backgroundColor: _buttonEnabled
                        ? MaterialStateProperty.all<Color>(Colors
                            .green) // Color de fondo cuando está habilitado
                        : MaterialStateProperty.all<Color>(Colors
                            .grey), // Color de fondo cuando está deshabilitado
                  ),

                  child: Text(
                    'Continuar',
                    style: TextStyle(
                        fontSize: 12,
                        color: _buttonEnabled ? Colors.white : Colors.blueGrey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  isLoaded() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const WelcomeScreen()));
  }
}
