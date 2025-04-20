import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:real_estate_app/bottom_bar.dart';
import 'package:real_estate_app/utils/colors.dart';
import 'package:real_estate_app/utils/extensions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final images = [
    'assets/images/apt-1.jpg',
    'assets/images/apt-2.jpg',
    'assets/images/apt-3.jpg',
    'assets/images/apt-1.jpg',
    'assets/images/apt-2.jpg',
    'assets/images/apt-3.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.grey[300]!,
                    // AppColors.darkGoldTint.withOpacity(0.3),
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
            CustomBottomNavBar(),
          ],
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

class CountRow extends StatelessWidget {
  const CountRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CustomPaint(
              size: Size(
                170.convertedWidth(context),
                170.convertedHeight(context),
              ),
              painter: OffersCircle(),
            ),
            SizedBox(
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
                    '1 034',
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
          ],
        ),
        const Gap(5),
        Stack(
          children: [
            CustomPaint(
              size: Size(
                170.convertedWidth(context),
                170.convertedHeight(context),
              ),
              painter: RentRect(),
            ),
            SizedBox(
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
                    '2 212',
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
          ],
        ),
      ],
    );
  }
}

class TopRow extends StatelessWidget {
  const TopRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CustomPaint(size: const Size(190, 50), painter: LocationRect()),
            SizedBox(
              width: 190,
              height: 50,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.darkGoldTint,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Center(
                    child: Text(
                      'Saint Petersburg',
                      style: TextStyle(
                        color: AppColors.darkGoldTint,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: AppColors.darkGoldTint,
          radius: 25,
          child: Icon(Icons.person, color: Colors.white, size: 24),
        ),
      ],
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
