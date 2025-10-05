import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightColor1,
    scaffoldBackgroundColor: const Color.fromARGB(255, 149, 205, 245),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightColor1,
      foregroundColor: AppColors.lightColor4,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightColor6,
    ),
    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
    colorScheme: ColorScheme.light(
      primary: AppColors.lightColor1,
      secondary: AppColors.lightColor6,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkColor1,
    scaffoldBackgroundColor: const Color.fromARGB(255, 78, 110, 133),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkColor1,
      foregroundColor: AppColors.darkColor3,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkColor6,
    ),
    inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder()),
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkColor1,
      secondary: AppColors.darkColor6,
    ),
  );
}
