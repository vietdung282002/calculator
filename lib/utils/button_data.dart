import 'package:calculator/utils/app_color.dart';
import 'package:calculator/utils/app_text_style.dart';
import 'package:flutter/material.dart';

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
      CalculatorButton("UNION", ButtonType.function),
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
      default:
        return Colors.white;
    }
  }

  static Widget getButtonChild(CalculatorButton button, ThemeMode mode) {
    switch (button.label) {
      case "C":
        return Text(
          button.label,
          style: AppTextStyle.buttonTextStyle,
        );
      case "UNION":
        if (mode == ThemeMode.light) {
          return Image.asset("assets/light_union.png");
        } else {
          return Image.asset("assets/dark_union.png");
        }
      case "%":
        return const Icon(Icons.percent_outlined);
      case "÷":
        return Image.asset("assets/divide.png");
      case "x":
        return Image.asset("assets/multiply.png");
      case "-":
        return Image.asset("assets/minus.png");
      case "+":
        return Image.asset("assets/plus.png");
      case ".":
        return Text(
          button.label,
          style: AppTextStyle.buttonTextStyle,
        );
      case "DEL":
        return const Icon(Icons.backspace_outlined);
      case "=":
        return Image.asset("assets/equal.png");
      default:
        return Text(
          button.label,
          style: AppTextStyle.buttonTextStyle,
        );
    }
  }
}
