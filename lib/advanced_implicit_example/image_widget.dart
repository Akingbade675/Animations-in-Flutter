import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learning_animations/advanced_implicit_example/hero_widget.dart';
import 'package:learning_animations/advanced_implicit_example/reuseable_text.dart';

class ImageWidget extends StatelessWidget {
  final int index;
  final String location;

  const ImageWidget({super.key, required this.index, required this.location});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      height: size.height * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: HeroWidget(
                  tag: 'image${index + 1}',
                  child: Image.asset(
                    'assets/images/image${index + 1}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReuseableText.title(text: location),
                  HeroWidget(
                    tag: 'latlong${index + 1}',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReuseableText.normal(
                          text: 'North Lat 24',
                        ),
                        const Icon(
                          Iconsax.location,
                          color: Colors.white,
                          size: 14,
                        ),
                        ReuseableText.normal(
                          text: 'East lng 17',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
