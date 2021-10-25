import 'package:flutter/material.dart';
import 'package:im/resources/app_colors.dart';

class PageIndicator extends StatelessWidget {
  PageIndicator({Key? key, this.indicatorColor = AppColors.secondaryInactive})
      : super(key: key);
  final indicatorColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: indicatorColor,
      ),
    );
  }
}
