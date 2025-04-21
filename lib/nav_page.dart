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

class _NavPageState extends State<NavPage> {
  List<Widget> pages = [
    const SearchPage(),
    const MyHomePage(),
    const MyHomePage(),
    const MyHomePage(),
    const MyHomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    final bottomBarInheritedW = BottomBarInheritedW.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            pages[bottomBarInheritedW?.currentIndex ?? 2],
            CustomBottomNavBar(),
          ],
        ),
      ),
    );
  }
}
