import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  //for light theme
  static final lighttheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.light,
    fontFamily: "Poppins",
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    scaffoldBackgroundColor: AppColors.lightbackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(12)),
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all(AppColors.lightbackground),
        textStyle: WidgetStateProperty.all(
          TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
    ),
  );

  //for dark theme
  static final darktheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.dark,
    fontFamily: "Poppins",
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    scaffoldBackgroundColor: AppColors.darkbackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.all(12)),
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all(AppColors.darkbackground),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
    ),
  );
}
