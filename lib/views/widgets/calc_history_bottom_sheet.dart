import 'package:calculator_app/utils/theme/app_colors.dart';
import 'package:calculator_app/view_models/history_list_cubit/history_list_cubit.dart';
import 'package:calculator_app/views/widgets/equation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcHistoryBottomSheet extends StatelessWidget {
  const CalcHistoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<HistoryListCubit>(context);
    return BlocBuilder<HistoryListCubit, HistoryListState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is FetchingHistory ||
          current is HistoryFetched ||
          current is FetchingHistoryFailed ||
          current is DeletingEquation ||
          current is EquationDeleted ||
          current is DeletingEquationFailed,
      builder: (context, state) {
        if (state is FetchingHistory || state is DeletingEquation) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state is EquationsLoaded) {
          final historyList = state.historyList;
          return SizedBox(
            height: size.height * 0.5,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close_rounded),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                            onPressed: () => cubit.activeDeletingEquation(),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            child: Text(
                              "Edit",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(color: AppColors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlocBuilder<HistoryListCubit, HistoryListState>(
                          bloc: cubit,
                          buildWhen: (previous, current) =>
                              current is ActiveDeletingEquations ||
                              current is CancelDeletingEquations,
                          builder: (context, state) {
                            if (state is ActiveDeletingEquations) {
                              return EquationWidget(
                                equation: historyList[index],
                                isDelete: true,
                              );
                            } else if (state is CancelDeletingEquations) {
                              return EquationWidget(
                                equation: historyList[index],
                                isDelete: false,
                              );
                            }
                            return EquationWidget(
                              equation: historyList[index],
                              isDelete: false,
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: historyList.length,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is FetchingHistoryFailed) {
          return Center(child: Text(state.message));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
