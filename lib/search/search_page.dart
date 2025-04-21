import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate_app/search/map_marker.dart';
import 'package:real_estate_app/utils/extensions.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    _scaleAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Future<void> _setMapStyle() async {
    String style = await rootBundle.loadString(
      'assets/map_styles/dark_map_style.json',
    );
    final controller = await _mapController.future;
    await controller.setMapStyle(style);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _mapController.future.then((controller) {
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Stack(
            children: [
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                  _setMapStyle();
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(59.9311, 30.3609),
                  zoom: 14,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: _scaleAnimation.value,
                        child: SizedBox(
                          width: 250.convertedWidth(context),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Saint Petersburg',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                      Gap(10),
                      Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.filter_list),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(top: 200, left: 100, child: MapMarker()),
              Positioned(top: 300, right: 80, child: MapMarker()),
              Positioned(bottom: 250, left: 150, child: MapMarker()),
              Positioned(bottom: 200, right: 50, child: MapMarker()),
              Positioned(
                bottom: 160,
                left: 20,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: _FrostedCircleButton(icon: Icons.wallet),
                ),
              ),
              Positioned(
                bottom: 100,
                left: 20,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: _FrostedCircleButton(icon: Icons.navigation_rounded),
                ),
              ),
              Positioned(
                bottom: 100,
                right: 20,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: FrostedGlass(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.list_rounded, color: Colors.white),
                          Gap(10),
                          Text(
                            'List of variants',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FrostedCircleButton extends StatelessWidget {
  final IconData icon;

  const _FrostedCircleButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return FrostedGlass(
      borderRadius: 50,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class FrostedGlass extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const FrostedGlass({super.key, required this.child, this.borderRadius = 20});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: child,
        ),
      ),
    );
  }
}
