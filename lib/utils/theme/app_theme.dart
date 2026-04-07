import 'package:calculator_app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeMode themeMode = .system;
  static ThemeData get appLightTheme => ThemeData(
    brightness: .light,
    primaryColor: AppColors.blue,
    scaffoldBackgroundColor: AppColors.white1,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.white2),
    ),
    textTheme: TextTheme(displayMedium: TextStyle(color: Colors.black)),
  );
  static ThemeData get appDarkTheme => ThemeData(
    brightness: .dark,
    scaffoldBackgroundColor: AppColors.black1,
    primaryColor: AppColors.blue,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.black2),
    ),
    textTheme: TextTheme(displayMedium: TextStyle(color: Colors.white)),
  );
}
