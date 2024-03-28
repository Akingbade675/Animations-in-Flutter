import 'package:flutter/material.dart';

class ReuseableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const ReuseableText({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
  });

  factory ReuseableText.title({required String text}) {
    return ReuseableText(
      text: text,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  factory ReuseableText.normal({required String text}) {
    return ReuseableText(
      text: text,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
