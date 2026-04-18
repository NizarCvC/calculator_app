import 'package:calculator_app/utils/app_constants.dart';
import 'package:calculator_app/utils/theme/app_theme.dart';
import 'package:calculator_app/view_models/calculator_cubit/calculator_cubit.dart';
import 'package:calculator_app/view_models/history_list_cubit/history_list_cubit.dart';
import 'package:calculator_app/views/pages/calculator_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CalculatorCubit()),
        BlocProvider(create: (context) => HistoryListCubit()),
      ],
      child: BlocBuilder<CalculatorCubit, CalculatorState>(
        buildWhen: (previous, current) => current is ChangeCalculatorThemeMode,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            themeMode: AppTheme.themeMode,
            theme: AppTheme.appLightTheme,
            darkTheme: AppTheme.appDarkTheme,
            home: const CalculatorPage(),
          );
        },
      ),
    );
  }
}
