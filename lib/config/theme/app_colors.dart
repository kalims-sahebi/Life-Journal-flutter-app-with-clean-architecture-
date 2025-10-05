import 'package:flutter/material.dart';

class AppColors {
  // Light mode colors (use fromARGB for all)
  static const Color lightColor1 = Color.fromARGB(255, 74, 144, 226);
  static const Color lightColor2 = Color.fromARGB(255, 255, 193, 7);
  static const Color lightColor3 = Color.fromARGB(255, 245, 245, 245);
  static const Color lightColor4 = Color.fromARGB(255, 33, 33, 33);
  static const Color lightColor5 = Color.fromARGB(255, 117, 117, 117);
  static const Color lightColor6 = Color.fromARGB(255, 0, 188, 212);

  // Dark mode colors (also use fromARGB)
  static const Color darkColor1 = Color.fromARGB(255, 8, 73, 81);
  static const Color darkColor2 = Color.fromARGB(255, 107, 82, 6);
  static const Color darkColor3 = Color.fromARGB(255, 130, 123, 123);
  static const Color darkColor4 = Color.fromARGB(255, 4, 3, 3);
  static const Color darkColor5 = Color.fromARGB(255, 66, 64, 64);
  static const Color darkColor6 = Color.fromARGB(255, 8, 82, 92);
}


//USAGE 
// Container(
//   color: context.color6, // Auto switches between lightColor6 and darkColor6
//   child: Text(
//     'Hello ARGB Colors!',
//     style: TextStyle(color: context.color1), // Auto switches too
//   ),
// );