import 'package:calculator_app/utils/theme/app_theme.dart';
import 'package:calculator_app/view_models/calculator_cubit/calculator_cubit.dart';
import 'package:calculator_app/view_models/history_list_cubit/history_list_cubit.dart';
import 'package:calculator_app/views/widgets/calc_history_bottom_sheet.dart';
import 'package:calculator_app/views/widgets/calculator_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _calculatorTextController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<CalculatorCubit>(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildAppBar(cubit, context),
              SizedBox(height: size.height * 0.035, width: double.infinity),
              _buildCalculatorText(context, cubit),
              SizedBox(height: size.height * 0.035, width: double.infinity),
              CalculatorGridView(cubit: cubit),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildCalculatorText(BuildContext context, CalculatorCubit cubit) {
    final size = MediaQuery.of(context).size;
    final textField = TextField(
      textAlign: .end,
      maxLength: 15,
      controller: _calculatorTextController,
      scrollPhysics: BouncingScrollPhysics(),
      readOnly: true,
      style: TextStyle(fontSize: size.height * 0.05),
      decoration: InputDecoration(border: .none, counterText: ""),
    );
    return SizedBox(
      height: size.height * 0.2,
      width: double.infinity,
      child: Align(
        alignment: .centerRight,
        child: BlocBuilder<CalculatorCubit, CalculatorState>(
          bloc: cubit,
          buildWhen: (previous, current) =>
              current is! ChangeCalculatorThemeMode,
          builder: (context, state) {
            if (state is CalculateResult) {
              _calculatorTextController.text = state.result;
              return Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .end,
                children: [
                  Text(
                    state.equation,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: Colors.grey),
                  ),
                  textField,
                ],
              );
            } else if (state is! CalculateResult && state is EquationChanged) {
              _calculatorTextController.text = state.equation;
              return textField;
            } else if (state is ClearCalculator) {
              return Text('', style: Theme.of(context).textTheme.displayMedium);
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Row _buildAppBar(CalculatorCubit cubit, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: cubit.toggleThemeMode,
          label: Icon(
            (AppTheme.themeMode == ThemeMode.light)
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,
            size: size.height * 0.03,
            color: Theme.of(context).primaryColor,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            await BlocProvider.of<HistoryListCubit>(
              context,
            ).fetchingHistoryList();
            if (!context.mounted) return;
            showModalBottomSheet(
              showDragHandle: true,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return CalcHistoryBottomSheet();
              },
            );
          },
          label: Icon(
            Icons.history,
            size: size.height * 0.03,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
