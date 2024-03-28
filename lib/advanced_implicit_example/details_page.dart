import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learning_animations/advanced_implicit_example/hero_widget.dart';
import 'package:learning_animations/advanced_implicit_example/reuseable_text.dart';
import 'package:learning_animations/advanced_implicit_example/stars_widget.dart';

class DetailsPage extends StatelessWidget {
  final Animation<double> animation;
  final int index;

  const DetailsPage({super.key, required this.animation, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const ReuseableText(
          text: 'Interests',
          fontWeight: FontWeight.normal,
        ),
        centerTitle: true,
        leading: const Icon(Iconsax.search_normal, color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Iconsax.backward5,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Positioned.fill(
                  child: HeroWidget(
                    tag: 'image${index + 1}',
                    child: Image.asset(
                      'assets/images/image${index + 1}.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 10,
                  child: HeroWidget(
                    tag: 'latlong${index + 1}',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReuseableText.normal(text: 'North Lat 24'),
                        const Icon(
                          Iconsax.location5,
                          color: Colors.white,
                          size: 16,
                        ),
                        ReuseableText.normal(text: 'East lng 17'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          DetailedInfoWidget(index: index),
          Expanded(
            flex: 5,
            child: ListView.separated(
              itemCount: 4,
              padding: EdgeInsets.zero,
              separatorBuilder: (context, index) => const Divider(height: 10),
              itemBuilder: (ctx, idx) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: const Interval(
                        0.2,
                        1,
                        curve: Curves.easeInExpo,
                      ),
                    );
                    return FadeTransition(
                      opacity: curvedAnimation,
                      child: child,
                    );
                  },
                  child: ReviewTile(index: index, idx: idx),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailedInfoWidget extends StatelessWidget {
  final int index;

  const DetailedInfoWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroWidget(
            tag: 'addressLine${index + 1}',
            child: const Text(
              'La Rambla, Barcelona, Catalonia, Spain',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 8),
          HeroWidget(
            tag: 'ratingNumber${index + 1}',
            child: const Text(
              'NO. 791181',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 8),
          HeroWidget(
            tag: 'ratingStar${index + 1}',
            child: const StarsWidget(),
          ),
        ],
      ),
    );
  }
}

class ReviewTile extends StatelessWidget {
  final int index;
  final int idx;

  const ReviewTile({
    super.key,
    required this.index,
    required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeroWidget(
            tag: 'person${index + 1}${idx + 1}',
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.grey,
              backgroundImage:
                  AssetImage('assets/icons/person${index + 1}.jpg'),
            ),
          ),
          const Text(
            'Michella Roberta',
          ),
          const Text(
            'FEB 14th',
          ),
          const Icon(Iconsax.like),
        ],
      ),
      subtitle: const Text(LOREM_IPSUM),
    );
  }
}

const LOREM_IPSUM =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
