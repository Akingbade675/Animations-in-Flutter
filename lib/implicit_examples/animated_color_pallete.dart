import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedColorPallete extends StatefulWidget {
  const AnimatedColorPallete({super.key});

  @override
  State<AnimatedColorPallete> createState() => _AnimatedColorPalleteState();
}

class _AnimatedColorPalleteState extends State<AnimatedColorPallete> {
  List colorPallete = generateColorPallete();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          5,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            margin: const EdgeInsets.all(8),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: colorPallete[index],
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: reGenerateColorPallete,
          child: const Text('Generate New Colors'),
        ),
      ],
    );
  }

  static List generateColorPallete() {
    final rand = Random();
    return List.generate(
      5,
      (_) => Color.fromARGB(
        255,
        rand.nextInt(256),
        rand.nextInt(256),
        rand.nextInt(256),
      ),
    );
  }

  void reGenerateColorPallete() {
    setState(() {
      colorPallete = generateColorPallete();
    });
  }
}
