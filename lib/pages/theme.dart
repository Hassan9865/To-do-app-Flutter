import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 68, 88, 105),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.indigo,
      secondary: Colors.black,
    ));

final darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple,
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.purple.shade200,
      secondary: Colors.white,
    ));
