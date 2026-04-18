import 'package:calculator_app/models/equation.dart';
import 'package:calculator_app/services/local_database_services.dart';
import 'package:calculator_app/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_list_state.dart';

class HistoryListCubit extends Cubit<HistoryListState> {
  HistoryListCubit() : super(HistoryListInitial());

  final _localDatabaseServices = LocalDatabaseServicesImpl();
  bool _isDeletingActive = false;

  Future<void> fetchingHistoryList() async {
    emit(FetchingHistory());

    try {
      _isDeletingActive = false;
      final historyList = await _prepareHistoryList();
      emit(HistoryFetched(historyList));
    } catch (e) {
      emit(FetchingHistoryFailed(e.toString()));
    }
  }

  Future<void> deleteEquationFromLocalDatabase(Equation equation) async {
    emit(DeletingEquation());

    try {
      final strList = await _prepareHistoryList();
      strList.removeWhere((e) => e.id == equation.id);

      await _localDatabaseServices.setStringList(
        AppConstants.localDatabaseKey,
        strList.map((e) => e.toJson()).toList(),
      );
      emit(EquationDeleted(strList));
    } catch (e) {
      emit(DeletingEquationFailed());
    }
  }

  void activeDeletingEquation() {
    _isDeletingActive = !_isDeletingActive;
    if (_isDeletingActive) {
      emit(ActiveDeletingEquations());
    } else {
      emit(CancelDeletingEquations());
    }
  }

  Future<List<Equation>> _prepareHistoryList() async {
    final fetchedList = await _localDatabaseServices.getStringList(
      AppConstants.localDatabaseKey,
    );

    if (fetchedList == null) {
      return [];
    }

    final historyList = fetchedList.map((e) => Equation.fromJson(e)).toList();

    return historyList;
  }
}
