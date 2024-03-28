import 'package:flutter/material.dart';

class UpDownArrow extends StatelessWidget {
  final bool isUp;
  final Color color;

  UpDownArrow({required this.isUp, required this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      isUp ? Icons.arrow_upward : Icons.arrow_downward,
      color: color,
    );
  }
}
