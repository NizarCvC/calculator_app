import 'package:calculator_app/utils/theme/app_colors.dart';
import 'package:calculator_app/utils/theme/app_theme.dart';
import 'package:calculator_app/view_models/cubit/calculator_cubit.dart';
import 'package:calculator_app/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<CalculatorCubit>(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
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
                    onPressed: () {},
                    label: Icon(
                      Icons.history,
                      size: size.height * 0.03,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05, width: double.infinity),
              SizedBox(
                height: size.height * 0.15,
                width: double.infinity,
                child: Align(
                  alignment: .centerRight,
                  child: BlocBuilder<CalculatorCubit, CalculatorState>(
                    bloc: cubit,
                    buildWhen: (previous, current) =>
                        current is! ChangeCalculatorThemeMode,
                    builder: (context, state) {
                      if (state is CalculateResult) {
                        return Column(
                          crossAxisAlignment: .end,
                          children: [
                            Text(
                              state.equation,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: Colors.grey),
                            ),
                            Text(
                              state.result,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        );
                      } else if (state is! CalculateResult &&
                          state is EquationState) {
                        return Text(
                          state.equation,
                          style: Theme.of(context).textTheme.displayMedium,
                        );
                      } else if (state is ClearCalculator) {
                        return Text(
                          '',
                          style: Theme.of(context).textTheme.displayMedium,
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.08, width: double.infinity),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: [
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: 'C',
                          onPressed: cubit.clearCalculator,
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '()',
                          onPressed: cubit.addParentheses,
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '/',
                          backgroundColor:
                              (AppTheme.themeMode == ThemeMode.light)
                              ? AppColors.lightBlue
                              : AppColors.darkBlue,
                          onPressed: () => cubit.addOperator('/'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '*',
                          backgroundColor:
                              (AppTheme.themeMode == ThemeMode.light)
                              ? AppColors.lightBlue
                              : AppColors.darkBlue,
                          onPressed: () => cubit.addOperator('*'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '7',
                          onPressed: () => cubit.addNumber('7'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '8',
                          onPressed: () => cubit.addNumber('8'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '9',
                          onPressed: () => cubit.addNumber('9'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '–',
                          backgroundColor:
                              (AppTheme.themeMode == ThemeMode.light)
                              ? AppColors.lightBlue
                              : AppColors.darkBlue,
                          onPressed: () => cubit.addOperator('-'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '4',
                          onPressed: () => cubit.addNumber('4'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '5',
                          onPressed: () => cubit.addNumber('5'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '6',
                          onPressed: () => cubit.addNumber('6'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '+',
                          backgroundColor:
                              (AppTheme.themeMode == ThemeMode.light)
                              ? AppColors.lightBlue
                              : AppColors.darkBlue,
                          onPressed: () => cubit.addOperator('+'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '1',
                          onPressed: () => cubit.addNumber('1'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '2',
                          onPressed: () => cubit.addNumber('2'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '3',
                          onPressed: () => cubit.addNumber('3'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 2,
                        child: CustomButton(
                          itemText: '=',
                          backgroundColor:
                              (AppTheme.themeMode == ThemeMode.light)
                              ? AppColors.lightBlue
                              : AppColors.darkBlue,
                          onPressed: cubit.calculateResult,
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '+/–',
                          onPressed: cubit.addNegative,
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '0',
                          onPressed: () => cubit.addNumber('0'),
                        ),
                      ),
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: CustomButton(
                          itemText: '.',
                          onPressed: cubit.addDecimalPoint,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
