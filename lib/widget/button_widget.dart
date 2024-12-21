import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color? backgroundColor;

  const ButtonWidget({
    super.key,
    required this.child,
    required this.onPressed,
    this.width = 70,
    this.height = 50,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            // foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: backgroundColor != null
                ? WidgetStateProperty.all<Color>(backgroundColor!)
                : null,
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
