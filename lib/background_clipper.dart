import 'package:flutter/material.dart';

class BackgroundClipper extends CustomClipper<Rect> {
  double animation;

  BackgroundClipper({required this.animation});
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: (size.height + 100) * animation,
        height: (size.height + 100) * animation);

    return rect;
  }

  @override
  bool shouldReclip(covariant BackgroundClipper oldClipper) {
    return animation != oldClipper.animation;
  }
}
