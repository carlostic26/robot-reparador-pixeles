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
  @override
  // ignore: must_call_super
  void initState() {
    //despues de 7 segundos se cambia de pantalla
    Future.delayed(const Duration(seconds: 5), () {
      isLoaded();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //no color backg cuz the backg is an image
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
                    animationDuration: 5000, //7 sec to load bar

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
