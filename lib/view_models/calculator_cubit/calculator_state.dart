part of 'calculator_cubit.dart';

sealed class CalculatorState {
  const CalculatorState();
}

final class CalculatorInitial extends CalculatorState {}

final class ChangeCalculatorThemeMode extends CalculatorState {}

final class EquationChanged extends CalculatorState {
  final String equation;

  const EquationChanged(this.equation);
}

final class ClearCalculator extends CalculatorState {}

final class CalculateResult extends EquationChanged {
  final String result;

  const CalculateResult(super.equation, {required this.result});
}
