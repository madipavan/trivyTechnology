import 'package:flutter/material.dart';

class GradientBorderBtn extends StatelessWidget {
  final List<Color> colorsList;
  final VoidCallback onPressed;
  final String label;
  final Color labelColor;
  const GradientBorderBtn(
      {super.key,
      required this.colorsList,
      required this.onPressed,
      required this.labelColor,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colorsList,
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      padding: EdgeInsets.all(.5),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
              color: labelColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              letterSpacing: -0.17),
        ),
      ),
    );
  }
}
