import 'package:calculator_app/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  String _equation = '';
  String _currentNumber = '';
  bool _isParenthesesClosed = true;

  void toggleThemeMode() {
    AppTheme.themeMode = AppTheme.themeMode == ThemeMode.light ? .dark : .light;
    emit(ChangeCalculatorThemeMode());
  }

  void clearCalculator() {
    _equation = '';
    _currentNumber = '';
    emit(ClearCalculator());
  }

  void addNumber(String number) {
    _equation += number;
    _currentNumber += number;
    emit(ClickOnNumber(_equation));
  }

  bool _isOperator(String operator) {
    return (operator == '+' ||
        operator == '-' ||
        operator == '/' ||
        operator == '*');
  }

  void addOperator(String operator) {
    if (_equation.isEmpty || _isOperator(_equation[_equation.length - 1])) {
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

  void addParentheses() {}

  void addNegative() {}

  void calculateResult() {}
}
