import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContextExt on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  double convertedHeight(double value) =>
      screenHeight * (value / 812); // iphone x height to scale
  double convertedWidth(double value) =>
      (value / 375) * screenWidth; // iphone x width to scale
}

extension NumExt on num {
  double convertedHeight(BuildContext context) =>
      context.screenHeight * (this / 812); // iphone x height to scale
  double convertedWidth(BuildContext context) =>
      (this / 375) * context.screenWidth; // iphone x width to scale
}
