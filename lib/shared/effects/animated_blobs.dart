import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedBlobs extends StatefulWidget {
  const AnimatedBlobs({super.key});

  @override
  State<AnimatedBlobs> createState() => _AnimatedBlobsState();
}

class _AnimatedBlobsState extends State<AnimatedBlobs>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          final t = controller.value;

          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: -120 + sin(t * pi * 2) * 25,
                left: -80,
                child: _blob(
                  340,
                  const Color(0xFF78906B).withValues(alpha: .055),
                ),
              ),

              Positioned(
                bottom: -150,
                right: -100 + cos(t * pi * 2) * 35,
                child: _blob(
                  420,
                  const Color(0xFFCDBB91).withValues(alpha: .07),
                ),
              ),

              Positioned(
                top: 260 + sin(t * pi * 4) * 20,
                right: -90,
                child: _blob(
                  250,
                  const Color(0xFFB7C4A9).withValues(alpha: .045),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            blurRadius: 120,
            spreadRadius: 10,
            color: color,
          ),
        ],
      ),
    );
  }
}
