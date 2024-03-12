import 'package:flutter/material.dart';

class MyTheme {
  static final ThemeData light = ThemeData(
    primaryColor: Colors.grey[350], // Color principal gris plateado
    hintColor: Colors.grey[600], // Color secundario un poco más oscuro
    buttonTheme: const ButtonThemeData(
      // Configuración de los botones
      buttonColor: Colors.white, // Botones oscuros
      textTheme: ButtonTextTheme.primary, // Texto de los botones blancos
    ),
  );
}
