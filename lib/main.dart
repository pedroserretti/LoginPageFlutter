// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_page_pmsf/app/authentication/main_page.dart';
import 'package:login_page_pmsf/app/ui/styles/colors_app.dart';
import 'package:login_page_pmsf/app/ui/theme/theme_config.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    ThemeConfig.setTheme();
    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    ThemeConfig.setTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeConfig.themePlatform,
      builder: (BuildContext context, Brightness themePlatform, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: ColorsApp.i.primary,
            secondary: ColorsApp.i.secondary,
            brightness: themePlatform,
          )
        ),
        home: MainPage()
      ),
    );
  }
}
