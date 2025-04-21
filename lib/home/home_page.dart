import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:real_estate_app/home/animated_top_widgets.dart';
import 'package:real_estate_app/utils/colors.dart';
import 'package:real_estate_app/utils/extensions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _sizeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final images = [
    'assets/images/apt-1.png',
    'assets/images/apt-2.png',
    'assets/images/apt-3.png',
    'assets/images/apt-1.png',
    'assets/images/apt-2.png',
    'assets/images/apt-3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.grey[300]!,
                AppColors.darkGoldTint.withOpacity(0.5),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              transform: GradientRotation(-0.7),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopRow(),
                Gap(30),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 50 * (1 - _sizeAnimation.value)),
                      child: Opacity(
                        opacity: _opacityAnimation.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, Marina',
                              style: TextStyle(
                                color: AppColors.darkGoldTint,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Text(
                                'let\'s select your perfect place',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Gap(20),
                CountRow(),
                Expanded(
                  child: DraggableScrollableSheet(
                    snap: true,
                    initialChildSize: 0.4,
                    minChildSize: 0.4,
                    maxChildSize: 1,
                    builder: (
                      BuildContext context,
                      ScrollController scrollController,
                    ) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: PropertyContainer(
                                  imagePath: images[index],
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                                bottom: 8,
                              ),
                              child: Row(
                                children: [
                                  PropertyContainer(
                                    imagePath: images[index],
                                    width: 165.convertedWidth(context),
                                  ),
                                  Spacer(),
                                  PropertyContainer(
                                    imagePath: images[index + 1],
                                    width: 165.convertedWidth(context),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PropertyContainer extends StatelessWidget {
  const PropertyContainer({super.key, required this.imagePath, this.width});

  final String imagePath;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      width: width,
      height: 200.convertedHeight(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
    );
  }
}

class CountRow extends StatefulWidget {
  const CountRow({super.key});

  @override
  State<CountRow> createState() => _CountRowState();
}

class _CountRowState extends State<CountRow> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  late Animation<double> _buyCountAnimation;
  late Animation<double> _rentCountAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _sizeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _buyCountAnimation = Tween<double>(
      begin: 0,
      end: 1034,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _rentCountAnimation = Tween<double>(
      begin: 0,
      end: 2212,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
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
      builder:
          (context, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Transform.scale(
                    scale: _sizeAnimation.value,
                    child: CustomPaint(
                      size: Size(
                        170.convertedWidth(context),
                        170.convertedHeight(context),
                      ),
                      painter: OffersCircle(),
                    ),
                  ),
                  Opacity(
                    opacity: _opacityAnimation.value,
                    child: SizedBox(
                      width: 170.convertedWidth(context),
                      height: 170.convertedHeight(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gap(5),
                          Text(
                            'BUY',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          const Gap(10),
                          Text(
                            _buyCountAnimation.value.toInt().toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                            ),
                          ),
                          const Gap(5),
                          Text('Offers', style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(5),
              Stack(
                children: [
                  Transform.scale(
                    scale: _sizeAnimation.value,
                    child: CustomPaint(
                      size: Size(
                        170.convertedWidth(context),
                        170.convertedHeight(context),
                      ),
                      painter: RentRect(),
                    ),
                  ),
                  Opacity(
                    opacity: _opacityAnimation.value,
                    child: SizedBox(
                      width: 170.convertedWidth(context),
                      height: 170.convertedHeight(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Gap(5),
                          Text(
                            'RENT',
                            style: TextStyle(
                              color: AppColors.darkGoldTint,
                              fontSize: 16,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            _rentCountAnimation.value.toInt().toString(),
                            style: TextStyle(
                              color: AppColors.darkGoldTint,
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                            ),
                          ),
                          const Gap(5),
                          Text(
                            'Offers',
                            style: TextStyle(color: AppColors.darkGoldTint),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }
}

class TopRow extends StatelessWidget {
  const TopRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [AnimatedLocationBox(), Spacer(), AnimatedTitleAvatar()],
    );
  }
}

class LocationRect extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topLeft: const Radius.circular(10),
        topRight: const Radius.circular(10),
        bottomLeft: const Radius.circular(10),
        bottomRight: const Radius.circular(10),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class OffersCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.amber[600]!
          ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class RentRect extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topLeft: const Radius.circular(10),
        topRight: const Radius.circular(10),
        bottomLeft: const Radius.circular(10),
        bottomRight: const Radius.circular(10),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
