part of 'history_list_cubit.dart';

sealed class HistoryListState {
  const HistoryListState();
}

final class HistoryListInitial extends HistoryListState {}

final class EquationsLoaded extends HistoryListState {
  final List<Equation> historyList;

  const EquationsLoaded(this.historyList);
}

final class FetchingHistory extends HistoryListState {}

final class HistoryFetched extends EquationsLoaded {
  HistoryFetched(super.historyList);
}

final class FetchingHistoryFailed extends HistoryListState {
  final String message;

  FetchingHistoryFailed(this.message);
}

final class DeletingEquation extends HistoryListState {}

final class EquationDeleted extends EquationsLoaded {
  EquationDeleted(super.historyList);
}

final class DeletingEquationFailed extends HistoryListState {}

final class ActiveDeletingEquations extends HistoryListState {}

final class CancelDeletingEquations extends HistoryListState {}
