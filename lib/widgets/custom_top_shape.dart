import '../resources/app_colors.dart';
import 'package:flutter/material.dart';

class TopShape extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 1;

    var path = Path();

    path.moveTo(0, size.height * 0.73);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.60,
        size.width * 0.55, size.height * 0.74);
    path.quadraticBezierTo(size.width * 0.8, size.height * 0.88, size.width * 1,
        size.height * 0.79);
    path.lineTo(size.width, -size.height);
    path.lineTo(0, -size.height);

    canvas.drawPath(path, paint);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
