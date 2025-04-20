import 'package:flutter/material.dart';

class BottomBarInheritedW extends InheritedWidget {
  const BottomBarInheritedW({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.onTap,
  }) : super(child: child);

  final Widget child;
  final int currentIndex;
  final Function(int) onTap ;

  static BottomBarInheritedW? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BottomBarInheritedW>();
  }

  @override
  bool updateShouldNotify(BottomBarInheritedW oldWidget) {
    return currentIndex != oldWidget.currentIndex;
  }
}
