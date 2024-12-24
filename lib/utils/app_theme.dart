import 'package:calculator/utils/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    final ThemeData base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColor.lightBackgroundColor,
      textTheme: base.textTheme.apply(
        fontFamily: 'WorkSans',
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.lightButtonColor,
          foregroundColor: Colors.black,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    final ThemeData base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColor.darkBackgroundColor,
      textTheme: base.textTheme.apply(
        fontFamily: 'WorkSans',
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.darkButtonColor,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
