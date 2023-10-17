import 'package:flutter/material.dart';
import 'package:robotreparadorpixeles/screens/home_AMOLED.dart';
import 'package:robotreparadorpixeles/screens/importaciones.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Seleccionar tipo de pantalla',
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontFamily: 'Silkscreen'),
              ),
              const SizedBox(
                height: 120,
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
                child: const Text('LCD'),
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
                child: const Text('AMOLED'),
              ),
            ],
          ),
        ));
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
