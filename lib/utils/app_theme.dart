import 'package:calculator/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme() {
    final ThemeData base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColor.lightBackgroundColor,
      textTheme: GoogleFonts.workSansTextTheme(base.textTheme).apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.lightButtonColor, // Set your desired color
          foregroundColor: Colors.black, // Set text color for ElevatedButton
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    final ThemeData base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColor.darkBackgroundColor,
      textTheme: GoogleFonts.workSansTextTheme(base.textTheme).apply(
        bodyColor:
            Colors.white, // Set default text color to white for dark theme
        displayColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.darkButtonColor, // Set your desired color
          foregroundColor: Colors.white, // Set text color for ElevatedButton
        ),
      ),
    );
  }
}
