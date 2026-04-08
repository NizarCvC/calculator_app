import 'package:flutter/material.dart';

class CalcHistoryBottomSheet extends StatelessWidget {
  const CalcHistoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      width: double.infinity,
      child: const Text('History'),
    );
  }
}
