import 'package:flutter/material.dart';
import 'package:real_estate_app/bottom_bar.dart';
import 'package:real_estate_app/home/home_page.dart';
import 'package:real_estate_app/search/search_page.dart';
import 'package:real_estate_app/utils/bottom_bar_inherited_widget.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  List<Widget> pages = [
    const SearchPage(),
    const MyHomePage(),
    const MyHomePage(),
    const MyHomePage(),
    const MyHomePage(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start off-screen (below)
      end: Offset.zero, // End at normal position
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward(); // Start the animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomBarInheritedW = BottomBarInheritedW.of(context);
    return Scaffold(
      body: Stack(
        children: [
          pages[bottomBarInheritedW?.currentIndex ?? 2],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
                child: Container(
                  width: double.infinity,
                  child: CustomBottomNavBar(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
