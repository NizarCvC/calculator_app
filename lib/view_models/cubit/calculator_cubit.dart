import 'package:calculator_app/services/local_database_services.dart';
import 'package:calculator_app/utils/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  final _localDatabaseServices = LocalDatabaseServicesImpl();

  String _equation = '';
  String _currentNumber = '';
  bool _isParenthesesClosed = true;

  void toggleThemeMode() {
    AppTheme.themeMode = AppTheme.themeMode == .light ? .dark : .light;
    emit(ChangeCalculatorThemeMode());
  }

  void clearCalculator() {
    _equation = '';
    _currentNumber = '';
    _isParenthesesClosed = true;
    emit(ClearCalculator());
  }

  void addNumber(String number) {
    _equation += number;
    _currentNumber += number;
    emit(ClickOnNumber(_equation));
  }

  void addOperator(String operator) {
    final String lastChar = (_equation.isEmpty)
        ? ''
        : _equation[_equation.length - 1];

    if (lastChar.isEmpty ||
        (_isParentheses(lastChar) && _isParenthesesClosed == false) ||
        _isOperator(lastChar)) {
      return;
    }

    _equation += operator;
    _currentNumber = '';
    emit(ClickOnOperator(_equation));
  }

  void addDecimalPoint() {
    if (_currentNumber.contains('.')) {
      return;
    }

    if (_currentNumber.isEmpty) {
      _equation += '0.';
      _currentNumber += '0.';
    } else {
      _equation += '.';
      _currentNumber += '.';
    }

    emit(ClickOnDecimalPoint(_equation));
  }

  void addParentheses() {
    final String lastChar = (_equation.isEmpty)
        ? ''
        : _equation[_equation.length - 1];

    if (_isParentheses(lastChar) ||
        (_isDigit(lastChar) && _isParenthesesClosed == true) ||
        (_isOperator(lastChar) && _isParenthesesClosed == false)) {
      return;
    }

    _equation += (_isParenthesesClosed) ? '(' : ')';
    _currentNumber = '';
    _isParenthesesClosed = !_isParenthesesClosed;
    emit(ClickOnParentheses(_equation));
  }

  void addNegative() {
    if (_equation.isEmpty ||
        (!_checkIfNumberNegativeByString(_currentNumber) &&
            !_isDigit(_equation[_equation.length - 1]))) {
      return;
    } else if (_equation.length == 1) {
      _equation = '(-$_equation)';
      _currentNumber = '(-$_currentNumber)';
    } else {
      int index = _indexOfLastOperator(_equation);
      _equation = _equation.substring(0, index + 1);

      if (_equation[_equation.length - 1] == '+') {
        _equation = _equation.replaceFirst('+', '-', index);
        _equation = _equation + _currentNumber;
      } else if (_equation[_equation.length - 1] == '-') {
        _equation = _equation.replaceFirst('-', '+', index);
        _equation = _equation + _currentNumber;
      } else if (_checkIfNumberNegativeByString(_currentNumber)) {
        final positiveNumber = _currentNumber.substring(
          2,
          _currentNumber.length - 1,
        );
        _equation = _equation + positiveNumber;
        _currentNumber = positiveNumber;
      } else {
        _equation = '$_equation(-$_currentNumber)';
        _currentNumber = '(-$_currentNumber)';
      }
    }

    emit(ClickOnNegative(_equation));
  }

  void calculateResult() {
    try {
      if (_equation.isEmpty) {
        return;
      }

      final normalized = _normalizeExpression(_equation);
      final parser = _ExpressionParser(normalized);
      final double result = parser.parse();

      String formattedResult;
      if (result % 1 == 0) {
        formattedResult = result.toInt().toString();
      } else {
        formattedResult = result.toString();
      }

      emit(CalculateResult(_equation, result: formattedResult));
    } catch (e) {
      emit(CalculateResult(_equation, result: 'Error'));
    }
  }

  bool _isParentheses(String s) {
    return s == '(' || s == ')';
  }

  bool _isDigit(String s) {
    return RegExp(r'^[0-9]$').hasMatch(s);
  }

  int _indexOfLastOperator(String equation) {
    for (int i = equation.length - 1; i >= 0; i--) {
      if (_isOperator(equation[i]) && i > 0 && equation[i - 1] != '(') {
        return i;
      }
    }
    return -1;
  }

  bool _checkIfNumberNegativeByString(String s) {
    return s.length >= 4 &&
        s.startsWith('(-') &&
        s.endsWith(')') &&
        double.tryParse(s.substring(2, s.length - 1)) != null;
  }

  bool _isOperator(String operator) {
    return operator == '+' ||
        operator == '-' ||
        operator == '/' ||
        operator == '*';
  }

  String _normalizeExpression(String input) {
    final regex = RegExp(r'\((\d+(\.\d+)?)\-\)');
    return input.replaceAllMapped(regex, (match) {
      final number = match.group(1)!;
      return '(-$number)';
    });
  }
}

class _ExpressionParser {
  final List<String> tokens;
  int index = 0;

  _ExpressionParser(String input) : tokens = _tokenize(input);

  static List<String> _tokenize(String input) {
    final tokens = <String>[];
    int i = 0;

    while (i < input.length) {
      final ch = input[i];

      if (ch == ' ') {
        i++;
        continue;
      }

      if ('()+-*/'.contains(ch)) {
        if (ch == '-') {
          final isUnary =
              tokens.isEmpty ||
              tokens.last == '(' ||
              tokens.last == '+' ||
              tokens.last == '-' ||
              tokens.last == '*' ||
              tokens.last == '/';

          if (isUnary) {
            int j = i + 1;
            String number = '-';

            while (j < input.length && '0123456789.'.contains(input[j])) {
              number += input[j];
              j++;
            }

            if (number != '-') {
              tokens.add(number);
              i = j;
              continue;
            }
          }
        }

        tokens.add(ch);
        i++;
        continue;
      }

      if ('0123456789.'.contains(ch)) {
        int j = i;
        String number = '';

        while (j < input.length && '0123456789.'.contains(input[j])) {
          number += input[j];
          j++;
        }

        tokens.add(number);
        i = j;
        continue;
      }

      throw FormatException('Invalid character: $ch');
    }

    return tokens;
  }

  String get current => index < tokens.length ? tokens[index] : '';

  bool match(String token) {
    if (current == token) {
      index++;
      return true;
    }
    return false;
  }

  double parse() {
    final value = _parseExpression();
    if (index < tokens.length) {
      throw FormatException('Unexpected token: ${tokens[index]}');
    }
    return value;
  }

  double _parseExpression() {
    double value = _parseTerm();

    while (true) {
      if (match('+')) {
        value += _parseTerm();
      } else if (match('-')) {
        value -= _parseTerm();
      } else {
        break;
      }
    }

    return value;
  }

  double _parseTerm() {
    double value = _parseFactor();

    while (true) {
      if (match('*')) {
        value *= _parseFactor();
      } else if (match('/')) {
        value /= _parseFactor();
      } else {
        break;
      }
    }

    return value;
  }

  double _parseFactor() {
    if (match('(')) {
      final value = _parseExpression();
      if (!match(')')) {
        throw FormatException('Missing closing parenthesis');
      }
      return value;
    }

    if (match('-')) {
      return -_parseFactor();
    }

    final token = current;
    final value = double.tryParse(token);

    if (value == null) {
      throw FormatException('Invalid number: $token');
    }

    index++;
    return value;
  }
}
