import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learning_animations/advanced_implicit_example/reuseable_text.dart';
import 'package:learning_animations/implicit_slider_example/draggable_widget.dart';

class AnimatedInfiniteSlider extends StatefulWidget {
  const AnimatedInfiniteSlider({super.key});

  @override
  State<AnimatedInfiniteSlider> createState() => _AnimatedInfiniteSliderState();
}

class _AnimatedInfiniteSliderState extends State<AnimatedInfiniteSlider>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    )..addListener(animationListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade400,
      appBar: AppBar(
        backgroundColor: Colors.purple.shade400,
        title: const ReuseableText(
          text: 'Interests',
          fontWeight: FontWeight.normal,
        ),
        centerTitle: true,
        leading: const Icon(Iconsax.search_normal, color: Colors.white),
        actions: const [
          Icon(Iconsax.location5, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: List.generate(
                  4,
                  (stackIndex) {
                    final modIndex = (index + 3 - stackIndex) % 9;
                    return Transform.rotate(
                      angle: getRotation(stackIndex),
                      child: Transform.translate(
                        offset: getOffset(stackIndex),
                        child: Transform.scale(
                          scale: getScale(stackIndex),
                          child: DraggableWidget(
                            isEnableDrag: stackIndex == 3,
                            onSlide: (direction) {
                              controller.forward();
                              // if (direction == SlideDirection.left) {
                              //   setState(() {});
                              // } else if (direction == SlideDirection.right) {
                              //   setState(() {});
                              // }
                            },
                            child: SliderImageWidget(index: modIndex),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        destinations: const [
          Icon(Iconsax.location, color: Colors.white),
          Icon(Iconsax.location_add, color: Colors.white),
          Icon(Iconsax.profile_2user, color: Colors.white),
        ],
      ),
    );
  }

  void animationListener() {
    if (controller.isCompleted) {
      setState(() {
        if (9 == ++index) index = 0;
      });
      controller.reset();
    }
  }

  double getRotation(int index) {
    const defaultAngle = pi * 0.1;
    return <int, double>{
          1: lerpDouble(-defaultAngle, defaultAngle, controller.value)!,
          2: lerpDouble(defaultAngle, 0, controller.value)!,
        }[index] ??
        lerpDouble(0, -defaultAngle, controller.value)!;
  }

  Offset getOffset(int index) {
    return <int, Offset>{
          0: Offset(lerpDouble(0, -70, controller.value)!, 30),
          1: Offset(lerpDouble(-70, 70, controller.value)!, 0),
          2: const Offset(70, 0) * (1 - controller.value),
        }[index] ??
        // Offset.zero;
        Offset(MediaQuery.of(context).size.width * controller.value, 0);
  }

  double getScale(int index) {
    return <int, double>{
          0: lerpDouble(0.6, 0.9, controller.value)!,
          1: lerpDouble(0.9, 0.95, controller.value)!,
          2: lerpDouble(0.95, 1, controller.value)!,
        }[index] ??
        1;
  }

  @override
  void dispose() {
    controller
      ..removeListener(animationListener)
      ..dispose();
    super.dispose();
  }
}

class SliderImageWidget extends StatelessWidget {
  final int index;

  const SliderImageWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.5,
      height: size.height * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage('assets/images/image${(index % 9) + 1}.jpg'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
    );
  }
}
