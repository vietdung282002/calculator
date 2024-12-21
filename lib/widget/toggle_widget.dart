import 'package:calculator/utils/app_color.dart';
import 'package:calculator/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToggleWidget extends StatelessWidget {
  const ToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ThemeProvider>(context, listen: false).toggleMode();
      },
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 60,
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: themeProvider.mode == ThemeMode.light
                ? AppColor.toggleLight
                : AppColor.toggleDark,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Align(
                alignment: themeProvider.mode == ThemeMode.light
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: themeProvider.mode == ThemeMode.light
                    ? Image.asset(
                        'assets/sun.png',
                        width: 18,
                        height: 18,
                      )
                    : Image.asset(
                        'assets/moon.png',
                        width: 18,
                        height: 18,
                      ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: themeProvider.mode == ThemeMode.light
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: themeProvider.mode == ThemeMode.light
                        ? AppColor.thumbLight
                        : AppColor.thumbDark,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
