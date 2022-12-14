import 'package:flutter/material.dart';

class CardItemChildTextWidget extends StatelessWidget {
  final double width;
  final double height;
  final String label;
  final double fontSize;

  const CardItemChildTextWidget({
    super.key,
    required this.width,
    required this.height,
    required this.label,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
