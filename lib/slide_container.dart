import 'package:flutter/material.dart';

class SlideContainer extends StatelessWidget {
  late final AnimationController animationController;
  final Size? size;
  final Widget? child;
  final Widget? oldChild;

  SlideContainer({
    required this.animationController,
    this.size,
    this.child,
    this.oldChild,
  });

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, -1),
  ).animate(
    CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
  );
  late final Animation<Offset> _newOffsetAnimation = Tween<Offset>(
    begin: const Offset(0, 1),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size?.height,
      width: size?.width,
      child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: Stack(
          children: [
            SlideTransition(
              position: _offsetAnimation,
              child: oldChild,
            ),
            SlideTransition(
              position: _newOffsetAnimation,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
