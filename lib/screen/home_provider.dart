import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeProvider extends ChangeNotifier {
  double _result = 0.0;
  String _resultString = '';
  String _operation = '';

  double get result => _result;
  String get resultString => _resultString;
  String get operation => _operation;

  void updateOperation(String value) {
    switch (value) {
      case '=':
        calculate();
        break;
      case 'C':
        _operation = '';
        _resultString = '';
        break;
      case 'DEL':
        if (_operation.isNotEmpty) {
          _operation = _operation.substring(0, _operation.length - 1);
        }
        break;
      case 'NEG':
        if (_operation.isNotEmpty &&
            RegExp(r'\d').hasMatch(_operation[_operation.length - 1])) {
          int i = _operation.length - 1;
          while (i >= 0 && RegExp(r'\d').hasMatch(_operation[i])) {
            i--;
          }
          if (i > 0 && (_operation[i] == '+' || _operation[i] == '-')) {
            _operation = _operation.substring(0, i) +
                (_operation[i] == '+' ? '-' : '+') +
                _operation.substring(i + 1);
          } else if (i == 0 && (_operation[i] == '+' || _operation[i] == '-')) {
            _operation = _operation.substring(0, i) +
                (_operation[i] == '+' ? '-' : '') +
                _operation.substring(i + 1);
          } else if (i < 0) {
            _operation = '-$_operation';
          }
        }
        break;
      case '%':
      case '÷':
      case 'x':
      case '+':
      case '-':
        if (_operation.isNotEmpty &&
            (RegExp(r'\d').hasMatch(_operation[_operation.length - 1]) ||
                _operation[_operation.length - 1] == '%')) {
          _operation += value;
        } else if (_operation.isNotEmpty &&
            (_operation[_operation.length - 1] == '+' ||
                _operation[_operation.length - 1] == '-' ||
                _operation[_operation.length - 1] == 'x' ||
                _operation[_operation.length - 1] == '÷')) {
          _operation = _operation.substring(0, _operation.length - 1) + value;
        }
        break;
      case '.':
        if (_operation.isNotEmpty &&
            RegExp(r'\d').hasMatch(_operation[_operation.length - 1])) {
          _operation += value;
        }
        break;
      default:
        _operation += value;
        int i = _operation.length - 1;
        while (i >= 0 &&
            (RegExp(r'\d|\.', unicode: true).hasMatch(_operation[i]) ||
                _operation[i] == ',')) {
          i--;
        }
        String numberString = _operation.substring(i + 1).replaceAll(',', '');
        if (!numberString.contains('.')) {
          String lastNumber = formartNumber(double.parse(numberString));
          _operation = _operation.substring(0, i + 1) + lastNumber;
        }
        break;
    }
    notifyListeners();
  }

  double _plus(double a, double b) {
    return a + b;
  }

  double _subtract(double a, double b) {
    return a - b;
  }

  double _multiply(double a, double b) {
    return a * b;
  }

  double _divide(double a, double b) {
    try {
      if (b == 0) {
        throw Exception('Division by zero');
      }
      return a / b;
    } catch (e) {
      return double.infinity; // or any other value to indicate error
    }
  }

  void calculate() {
    try {
      if (_operation.isNotEmpty &&
          (_operation[_operation.length - 1] == '+' ||
              _operation[_operation.length - 1] == '-' ||
              _operation[_operation.length - 1] == 'x' ||
              _operation[_operation.length - 1] == '÷')) {
        _result = 0;
        _resultString = 'Error';
        return;
      }
      final result = _evaluateExpression(_operation);
      _result = result;
      _resultString = formartNumber(result);
    } catch (e) {
      _result = 0;
      _resultString = 'Error';
    }
    notifyListeners();
  }

  double _evaluateExpression(String expression) {
    var tokens = _transformExpressionToPostfix(expression);

    var result = <double>[];

    for (var i = 0; i < tokens.length; i++) {
      if (tokens[i] is double) {
        result.add(tokens[i]);
      } else {
        double calculation;
        double firstOperand;
        double secondOperand = result.removeLast();
        if (tokens[i] == '%') {
          calculation = _multiply(secondOperand, 0.01);
        } else {
          firstOperand = result.isEmpty ? 0 : result.removeLast();

          switch (tokens[i]) {
            case '+':
              calculation = _plus(firstOperand, secondOperand);
              break;
            case '-':
              calculation = _subtract(firstOperand, secondOperand);
              break;
            case 'x':
              calculation = _multiply(firstOperand, secondOperand);
              break;
            case '÷':
              calculation = _divide(firstOperand, secondOperand);
              break;
            default:
              throw Exception('Unknown operator');
          }
        }
        result.add(calculation);
      }
    }
    return result[0];
  }

  List _transformExpressionToPostfix(String expression) {
    var tokens = <dynamic>[];
    var num = '';

    for (var i = 0; i < expression.length; i++) {
      var char = expression[i];
      if (char == ',') {
        continue;
      }
      if (RegExp(r'\d').hasMatch(char) || char == '.') {
        num += char;
      } else {
        if (num.isNotEmpty) {
          tokens.add(double.parse(num));
          num = '';
        }
        if (char == '+' ||
            char == '-' ||
            char == 'x' ||
            char == '÷' ||
            char == '%') {
          tokens.add(char);
        }
      }
    }
    if (num.isNotEmpty) {
      tokens.add(double.parse(num));
    }

    var output = <dynamic>[];
    var operatorStack = <String>[];

    for (var token in tokens) {
      if (token is double) {
        output.add(token);
      } else if (token is String) {
        while (operatorStack.isNotEmpty &&
            precedence(operatorStack.last) >= precedence(token)) {
          output.add(operatorStack.removeLast());
        }
        operatorStack.add(token);
      }
    }

    while (operatorStack.isNotEmpty) {
      output.add(operatorStack.removeLast());
    }
    return output;
  }

  int precedence(String operator) {
    if (operator == '+' || operator == '-') return 1;
    if (operator == 'x' || operator == '÷' || operator == '%') return 2;
    return 0; // Parentheses or other operators
  }

  String formartNumber(double rawNumber) {
    if (rawNumber % 1 == 0) {
      String formatted = NumberFormat('###,###').format(rawNumber);
      return formatted;
    } else {
      var stringParts = rawNumber.toString().split('.');
      stringParts[0] =
          NumberFormat('###,###').format(int.parse(stringParts[0]));
      return "${stringParts[0]}.${stringParts[1]}";
    }
  }
}
