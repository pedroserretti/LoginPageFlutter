import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeConfig {
  
  ThemeConfig._();

  static ValueNotifier<Brightness> themePlatform= ValueNotifier(Brightness.light);

  static setTheme() {
    themePlatform.value = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    changeStatusNavigationBar();
  }

  static changeStatusNavigationBar() {
    bool isDark = themePlatform.value == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarColor: isDark ? const Color(0xFF424242) : const Color(0xFF00F37E),
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: isDark ? const Color(0xFF303030) : const Color(0xFF303030),
      systemNavigationBarDividerColor: isDark ? const Color(0xFF303030) : const Color(0xFF303030),
    ));
  }
}
