import 'package:flutter/material.dart';
import 'package:trivytech/presentation/splashscreen/splash_screen.dart';

import 'core/configs/themes/app_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darktheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      title: "YOLO",
    );
  }
}
