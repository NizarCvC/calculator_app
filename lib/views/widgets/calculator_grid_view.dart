import 'package:calculator_app/utils/theme/app_colors.dart';
import 'package:calculator_app/utils/theme/app_theme.dart';
import 'package:calculator_app/view_models/calculator_cubit/calculator_cubit.dart';
import 'package:calculator_app/views/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CalculatorGridView extends StatelessWidget {
  const CalculatorGridView({
    super.key,
    required this.cubit,
  });

  final CalculatorCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
