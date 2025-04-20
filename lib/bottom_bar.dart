import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/bottom_bar_inherited_widget.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomBarInheritedW(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      child: Positioned(
        left: 16,
        right: 16,
        bottom: 24,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: currentIndex == 0 ? Colors.amber : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.search, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: currentIndex == 1 ? Colors.amber : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.message, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: currentIndex == 2 ? Colors.amber : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.home, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: currentIndex == 3 ? Colors.amber : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.favorite, color: Colors.white),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: currentIndex == 4 ? Colors.amber : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
