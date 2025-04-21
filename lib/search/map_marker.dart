import 'package:flutter/material.dart';

class MapMarker extends StatefulWidget {
  const MapMarker({super.key});

  @override
  State<MapMarker> createState() => _MapMarkerState();
}

class _MapMarkerState extends State<MapMarker> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _reverseController;
  late Animation<double> _reverseWidthAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _reverseOpacityAnimation;

  bool isReversed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _reverseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    _reverseWidthAnimation = Tween<double>(begin: 1.0, end: 0.51).animate(
      CurvedAnimation(parent: _reverseController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _reverseOpacityAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(parent: _reverseController, curve: Curves.easeInOut),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _reverseController.forward();
        });
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _reverseWidthAnimation.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() {
          isReversed = true;
        });
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _reverseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_animationController, _reverseController]),
      builder: (context, _) {
        return Transform.scale(
          scale: isReversed ? 1 : _scaleAnimation.value,
          child: Container(
            width:
                isReversed
                    ? _reverseWidthAnimation.value * 70
                    : 70 * _scaleAnimation.value,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.amber[700],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(9),
                topLeft: Radius.circular(9),
                bottomRight: Radius.circular(9),
              ),
            ),
            child: Opacity(
              opacity:
                  isReversed
                      ? _reverseOpacityAnimation.value
                      : _opacityAnimation.value,
              child:
                  isReversed
                      ? Icon(Icons.business, color: Colors.white, size: 24)
                      : Center(
                        child: Text(
                          '1043',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
            ),
          ),
        );
      },
    );
  }
}
