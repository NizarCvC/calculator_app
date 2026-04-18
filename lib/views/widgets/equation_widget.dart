import 'package:calculator_app/models/equation.dart';
import 'package:calculator_app/view_models/history_list_cubit/history_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EquationWidget extends StatelessWidget {
  final Equation equation;
  final bool isDelete;
  const EquationWidget({
    super.key,
    required this.equation,
    required this.isDelete,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<HistoryListCubit>(context);

    return SizedBox(
      height: size.height * 0.08,
      width: double.infinity,
      child: ListTile(
        title: Column(
          crossAxisAlignment: .end,
          children: [
            Column(
              children: [
                Text(equation.equation, maxLines: 1),
                Text(
                  equation.result,
                  maxLines: 1,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: .w600),
                ),
              ],
            ),
          ],
        ),
        leading: (isDelete)
            ? IconButton(
                onPressed: () =>
                    cubit.deleteEquationFromLocalDatabase(equation),
                icon: Icon(Icons.delete_outline_outlined),
              )
            : null,
      ),
    );
  }
}
