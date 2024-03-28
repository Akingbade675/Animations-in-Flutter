import 'package:flutter/material.dart';
import 'package:learning_animations/advanced_implicit_example/details_page.dart';
import 'package:learning_animations/advanced_implicit_example/hero_widget.dart';
import 'package:learning_animations/advanced_implicit_example/image_widget.dart';
import 'package:learning_animations/advanced_implicit_example/stars_widget.dart';

class PageViewItem extends StatefulWidget {
  const PageViewItem({
    super.key,
    required this.location,
    required this.index,
  });

  final String location;
  final int index;

  @override
  State<PageViewItem> createState() => _PageViewItemState();
}

class _PageViewItemState extends State<PageViewItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          bottom: isExpanded ? 90 : 150,
          width: isExpanded ? size.width * 0.8 : size.width * 0.7,
          height: isExpanded ? size.height * 0.6 : size.height * 0.5,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: isExpanded ? 1 : 0.2,
            child: LocationInfo(index: widget.index),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 500),
          bottom: isExpanded ? 200 : 150,
          child: GestureDetector(
            onTap: onTap,
            onPanUpdate: onPanUpdate,
            child: ImageWidget(
              index: widget.index,
              location: widget.location,
            ),
          ),
        ),
      ],
    );
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dy < 0) {
      setState(() {
        isExpanded = true;
      });
    } else if (details.delta.dy > 0) {
      setState(() {
        isExpanded = false;
      });
    }
  }

  void onTap() {
    if (!isExpanded) {
      setState(() {
        isExpanded = true;
      });
      return;
    }

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return DetailsPage(animation: animation, index: widget.index);
        },
        transitionDuration: const Duration(seconds: 1),
        reverseTransitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.5),
          );
          return FadeTransition(
            opacity: curvedAnimation,
            child: child,
          );
        },
      ),
    );
  }
}

class LocationInfo extends StatelessWidget {
  final int index;

  const LocationInfo({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Address
          HeroWidget(
            tag: 'addressLine${index + 1}',
            child: const Text(
              'La Rambla, Barcelona, Catalonia, Spain',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              HeroWidget(
                tag: 'ratingNumber${index + 1}',
                child: const Text(
                  'NO. 791181',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              const Spacer(),
              HeroWidget(
                tag: 'ratingStar${index + 1}',
                child: const StarsWidget(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(
              4,
              (idx) => Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: HeroWidget(
                  tag: 'person${index + 1}${idx + 1}',
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        AssetImage('assets/icons/person${index + 1}.jpg'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
