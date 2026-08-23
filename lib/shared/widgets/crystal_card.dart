import 'package:flutter/material.dart';

class CrystalCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  const CrystalCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  State<CrystalCard> createState() => _CrystalCardState();
}

class _CrystalCardState extends State<CrystalCard> {
  bool hovered = false;
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => pressed = true),
        onTapUp: (_) {
          setState(() => pressed = false);
          widget.onTap?.call();
        },
        onTapCancel: () => setState(() => pressed = false),
        child: AnimatedScale(
          duration: const Duration(milliseconds: 150),
          scale: pressed ? .985 : hovered ? 1.01 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: const Color(0xFFFCFBF7),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFE4E0D5),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: hovered ? 24 : 14,
                  spreadRadius: 0,
                  color: const Color(0xFF5A4A36).withValues(
                    alpha: hovered ? .10 : .06,
                  ),
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Padding(
              padding: widget.padding,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
