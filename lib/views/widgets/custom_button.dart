import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String itemText;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  const CustomButton({
    super.key,
    required this.itemText,
    required this.onPressed,
    this.backgroundColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          scale = 0.9;
        });
      },
      onTapUp: (_) {
        setState(() {
          scale = 0.9;
        });
      },
      onTapCancel: () {
        setState(() {
          scale = 1.0;
        });
      },
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        child: ElevatedButton(
          onPressed: widget.onPressed, //
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            backgroundColor: widget.backgroundColor,
          ),
          child: Text(
            widget.itemText,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
