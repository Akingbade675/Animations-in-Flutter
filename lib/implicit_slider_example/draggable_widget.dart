import 'dart:math';

import 'package:flutter/material.dart';

enum SlideDirection { left, right }

class DraggableWidget extends StatefulWidget {
  final Widget child;
  final bool isEnableDrag;
  final ValueChanged<SlideDirection> onSlide;

  const DraggableWidget({
    super.key,
    required this.child,
    required this.isEnableDrag,
    required this.onSlide,
  });

  @override
  State<DraggableWidget> createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  Offset startOffset = Offset.zero;
  Offset panOffset = Offset.zero;

  final _widgetKey = GlobalKey();
  Size size = Size.zero;
  double angle = 0;

  late Size screenSize;

  double get outSizeLimit => size.width * 0.65;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
    )..addListener(animationListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenSize = MediaQuery.of(context).size;
      getWidgetSize();
    });
  }

  void animationListener() {
    if (controller.isCompleted) {
      controller.reset();
      panOffset = Offset.zero;
      angle = 0;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = SizedBox(key: _widgetKey, child: widget.child);

    if (!widget.isEnableDrag) return child;

    return GestureDetector(
      onPanStart: (details) {
        setState(() {
          startOffset = details.globalPosition;
        });
      },
      onPanUpdate: (DragUpdateDetails details) {
        if (controller.isAnimating) return;

        setState(() {
          panOffset = details.globalPosition - startOffset;
          angle = currentAngle;
        });
      },
      onPanEnd: (DragEndDetails details) {
        if (controller.isAnimating) return;

        final velocityX = details.velocity.pixelsPerSecond.dx;
        final positionX = currentPosition.dx;

        if (velocityX < -1000 || positionX < -outSizeLimit) {
          print('Slide left');
          widget.onSlide.call(SlideDirection.left);
        }

        if (velocityX > 1000 || positionX > screenSize.width - outSizeLimit) {
          print('Slide right');
          widget.onSlide(SlideDirection.right);
        }

        controller.forward();
      },
      child: AnimatedBuilder(
          animation: controller,
          child: child,
          builder: (context, child) {
            final value = 1 - controller.value;
            return Transform.translate(
              offset: panOffset * value,
              child: Transform.rotate(
                angle: angle,
                child: child,
              ),
            );
          }),
    );
  }

  Offset get currentPosition {
    final renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(Offset.zero);
  }

  double get currentAngle {
    return currentPosition.dx < 0
        ? (pi * 0.2) * currentPosition.dx / size.width
        : currentPosition.dx + size.width > screenSize.width
            ? (pi * 0.2) *
                (currentPosition.dx + size.width - screenSize.width) /
                size.width
            : 0;
  }

  void getWidgetSize() {
    size =
        (_widgetKey.currentContext?.findRenderObject() as RenderBox?)?.size ??
            Size.zero;
  }

  @override
  void dispose() {
    controller.removeListener(animationListener);
    controller.dispose();
    super.dispose();
  }
}
