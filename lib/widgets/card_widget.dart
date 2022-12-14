import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final double height;
  final double width;
  final Widget widget;

  const CardWidget({
    super.key,
    required this.height,
    required this.width,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 0.1 * height,
      ),
      width: width,
      height: 0.8 * height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        // implement shadow effect
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(3, 3),
            spreadRadius: 0.1,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: widget,
    );
  }
}
