import 'package:flutter/material.dart';
import 'package:real_estate_app/home/home_page.dart';
import 'package:real_estate_app/utils/colors.dart';

class AnimatedLocationBox extends StatefulWidget {
  const AnimatedLocationBox({super.key});

  @override
  State<AnimatedLocationBox> createState() => _AnimatedLocationBoxState();
}

class _AnimatedLocationBoxState extends State<AnimatedLocationBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _widthAnimation = Tween<double>(
      begin: 0,
      end: 190,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            CustomPaint(
              size: Size(_widthAnimation.value, 50),
              painter: LocationRect(),
            ),
            SizedBox(
              width: _widthAnimation.value,
              height: 50,
              child: Row(
                children: [
                  if (_widthAnimation.value > 180) ...[
                    Icon(
                      Icons.location_on,
                      color: AppColors.darkGoldTint,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Opacity(
                      opacity: _opacityAnimation.value,
                      child: Center(
                        child: Text(
                          'Saint Petersburg',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.darkGoldTint,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class AnimatedTitleAvatar extends StatefulWidget {
  const AnimatedTitleAvatar({super.key});

  @override
  State<AnimatedTitleAvatar> createState() => _AnimatedTitleAvatarState();
}

class _AnimatedTitleAvatarState extends State<AnimatedTitleAvatar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _sizeAnimation = Tween<double>(
      begin: 0,
      end: 25,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CircleAvatar(
          backgroundColor: AppColors.darkGoldTint,
          radius: _sizeAnimation.value,
          child: Icon(Icons.person, color: Colors.white, size: 24),
        );
      },
    );
  }
}
