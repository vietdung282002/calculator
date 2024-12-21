import 'package:calculator/screen/home_provider.dart';
import 'package:calculator/utils/app_color.dart';
import 'package:calculator/utils/app_theme.dart';
import 'package:calculator/screen/home_screen.dart';
import 'package:calculator/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          _setSystemOverlayStyle(themeProvider.mode);
          return MaterialApp(
            title: 'Flutter Demo',
            themeMode: themeProvider.mode,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            home: child,
          );
        },
        child: const HomeScreen(),
      ),
    );
  }

  void _setSystemOverlayStyle(ThemeMode themeMode) {
    if (themeMode == ThemeMode.light) {
      // Light mode
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: AppColor.lightBackgroundColor,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      // Dark mode
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: AppColor.darkBackgroundColor,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    }
  }
}
