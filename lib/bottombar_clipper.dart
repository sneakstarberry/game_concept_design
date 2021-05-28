import 'dart:math';

import 'package:flutter/material.dart';

class BottomBarCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double degToRad(num deg) => deg * (pi / 180.0);
    Path path = Path();
    path.moveTo(size.width * 0.0, size.height);
    path.lineTo(size.width * 0.0, size.height * 0.5);
    path.conicTo(size.width * 0.03, size.height * 0.30, size.width / 2 - 25,
        size.height * 0.2, 4);

    path.arcTo(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height * 0.2),
            width: 50,
            height: 40),
        degToRad(180),
        degToRad(-180),
        false);
    path.conicTo(size.width * 0.97, size.height * 0.30, size.width * 1,
        size.height * 0.5, 4);
    path.lineTo(size.width * 1.0, size.height * 0.5);
    path.lineTo(size.width * 1.0, size.height * 1.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
