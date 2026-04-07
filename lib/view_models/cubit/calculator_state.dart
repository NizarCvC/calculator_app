part of 'calculator_cubit.dart';

sealed class CalculatorState {
  const CalculatorState();
}

final class CalculatorInitial extends CalculatorState {}

final class ChangeCalculatorThemeMode extends CalculatorState {}

abstract class EquationState extends CalculatorState {
  final String equation;

  const EquationState(this.equation);
}

final class ClickOnNumber extends EquationState {
  const ClickOnNumber(super.equation);
}

final class ClickOnNegative extends EquationState {
  ClickOnNegative(super.equation);
}

final class ClickOnOperator extends EquationState {
  const ClickOnOperator(super.equation);
}

final class ClickOnDecimalPoint extends EquationState {
  const ClickOnDecimalPoint(super.equation);
}

final class ClickOnParentheses extends EquationState {
  const ClickOnParentheses(super.equation);
}

final class ClearCalculator extends CalculatorState {}

final class CalculateResult extends EquationState {
  final String result;

  const CalculateResult(super.equation, {required this.result});
}
