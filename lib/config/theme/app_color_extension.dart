import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

extension AppColorExt on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get color1 => isDarkMode ? AppColors.darkColor1 : AppColors.lightColor1;
  Color get color2 => isDarkMode ? AppColors.darkColor2 : AppColors.lightColor2;
  Color get color3 => isDarkMode ? AppColors.darkColor3 : AppColors.lightColor3;
  Color get color4 => isDarkMode ? AppColors.darkColor4 : AppColors.lightColor4;
  Color get color5 => isDarkMode ? AppColors.darkColor5 : AppColors.lightColor5;
  Color get color6 => isDarkMode ? AppColors.darkColor6 : AppColors.lightColor6;
}
