import 'dart:ui';
import 'package:flutter/material.dart';

class SwitchPainter extends CustomPainter {
  final double switcherStep;

  final double heightToRadiusRatio;
  final Color sunColor;
  final Color backgroundColor;

  SwitchPainter(this.switcherStep,
      {this.sunColor, this.backgroundColor, this.heightToRadiusRatio});

  @override
  void paint(Canvas canvas, Size size) {
    _paintBackground(canvas, size, _paintBuilder(backgroundColor));
    _paintSun(canvas, size, _paintBuilder(sunColor),
        _paintBuilder(backgroundColor), switcherStep, heightToRadiusRatio);
  }

  @override
  bool shouldRepaint(SwitchPainter oldDelegate) => true;

  void _paintBackground(Canvas canvas, Size size, Paint paintSun) {
    final radiusSun = size.height / 2;

    final path = Path()
      ..moveTo(radiusSun, 0)
      ..lineTo(size.width - radiusSun, 0)
      ..arcToPoint(Offset(size.width - radiusSun, size.height),
          radius: Radius.circular(radiusSun), clockwise: true)
      ..lineTo(radiusSun, size.height)
      ..arcToPoint(Offset(radiusSun, 0),
          radius: Radius.circular(radiusSun), clockwise: true);

    canvas.drawPath(path, paintSun);
  }

  void _paintSun(Canvas canvas, Size size, Paint sunPaint, Paint moonPaint,
      double step, double heightToRadiusRatio) {
    final sunRadius = size.height / 2;
    final moonRadius = sunRadius / 2;
    final indentFromRight = sunRadius + sunRadius / 2;

    final sunStep = sunRadius + (size.width - size.height) * step;
    final moonStep = (size.width - indentFromRight) * step;

    final moonStepRadius =
        (moonRadius + (1 - heightToRadiusRatio) * moonRadius / 2) * step;

    canvas
      ..drawCircle(
          Offset(sunStep, sunRadius), sunRadius * heightToRadiusRatio, sunPaint)
      ..drawCircle(Offset(moonStep, sunRadius), moonStepRadius, moonPaint);
  }

  Paint _paintBuilder(Color color) => Paint()
    ..color = color
    ..style = PaintingStyle.fill;
}
