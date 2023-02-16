import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get i {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primary => const Color(0xFF00F37E);
  Color get secondary => const Color(0xFF0DF015);
  Color get darkMode => const Color(0xFF303030);
  Color get lightMode => const Color(0xFFEEEEEE);
}

extension ColorsAppExtensions on BuildContext {
  ColorsApp get colors => ColorsApp.i;
}