import 'package:calculator/utils/app_color.dart';
import 'package:calculator/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum ButtonType {
  function,
  operation,
  number,
}

class CalculatorButton {
  final String label;
  final ButtonType type;

  CalculatorButton(this.label, this.type);
}

class ButtonData {
  static List<List<CalculatorButton>> buttons = [
    [
      CalculatorButton("C", ButtonType.function),
      CalculatorButton("NEG", ButtonType.function),
      CalculatorButton("%", ButtonType.function),
      CalculatorButton("÷", ButtonType.operation),
    ],
    [
      CalculatorButton("7", ButtonType.number),
      CalculatorButton("8", ButtonType.number),
      CalculatorButton("9", ButtonType.number),
      CalculatorButton("x", ButtonType.operation),
    ],
    [
      CalculatorButton("4", ButtonType.number),
      CalculatorButton("5", ButtonType.number),
      CalculatorButton("6", ButtonType.number),
      CalculatorButton("-", ButtonType.operation),
    ],
    [
      CalculatorButton("1", ButtonType.number),
      CalculatorButton("2", ButtonType.number),
      CalculatorButton("3", ButtonType.number),
      CalculatorButton("+", ButtonType.operation),
    ],
    [
      CalculatorButton(".", ButtonType.number),
      CalculatorButton("0", ButtonType.number),
      CalculatorButton("DEL", ButtonType.number),
      CalculatorButton("=", ButtonType.operation),
    ],
  ];

  static Color getButtonColor(CalculatorButton button, ThemeMode mode) {
    switch (button.type) {
      case ButtonType.operation:
        return AppColor.operatorButton;
      case ButtonType.function:
        if (mode == ThemeMode.light) {
          return AppColor.lightFunctionButton;
        } else {
          return AppColor.darkFunctionButton;
        }
      case ButtonType.number:
        if (mode == ThemeMode.light) {
          return AppColor.lightNumberButton;
        } else {
          return AppColor.darkNumberButton;
        }
    }
  }

  static Widget getButtonChild(CalculatorButton button, ThemeMode mode) {
    switch (button.label) {
      case "NEG":
        return SvgPicture.asset(
          "assets/negative.svg",
          colorFilter: ColorFilter.mode(
            mode == ThemeMode.light ? Colors.black : Colors.white,
            BlendMode.srcIn,
          ),
        );
      case "%":
        return SvgPicture.asset(
          "assets/percentage.svg",
          colorFilter: ColorFilter.mode(
            mode == ThemeMode.light ? Colors.black : Colors.white,
            BlendMode.srcIn,
          ),
        );
      case "÷":
        return SvgPicture.asset(
          "assets/divide.svg",
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      case "x":
        return SvgPicture.asset(
          "assets/multiply.svg",
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      case "-":
        return SvgPicture.asset(
          "assets/minus.svg",
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      case "+":
        return SvgPicture.asset(
          "assets/plus.svg",
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      case "DEL":
        return Icon(
          Icons.backspace_outlined,
          size: 24,
          color: mode == ThemeMode.light ? Colors.black : Colors.white,
        );
      case "=":
        return SvgPicture.asset(
          "assets/equal.svg",
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        );
      default:
        return Text(
          button.label,
          style: mode == ThemeMode.light
              ? AppTextStyle.buttonTextLightStyle
              : AppTextStyle.buttonTextDarkStyle,
        );
    }
  }
}
