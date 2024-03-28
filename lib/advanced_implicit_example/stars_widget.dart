import 'package:flutter/material.dart';

class StarsWidget extends StatelessWidget {
  const StarsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => const Padding(
          padding: EdgeInsets.only(right: 2.0),
          child: Icon(
            Icons.star,
            color: Colors.blueGrey,
            size: 16,
          ),
        ),
      ),
    );
  }
}
