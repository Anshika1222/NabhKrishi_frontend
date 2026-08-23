import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  String language = 'English';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _animate(
    double begin,
    double end, {
    Curve curve = Curves.easeOutCubic,
  }) {
    final value = CurvedAnimation(
      parent: _controller,
      curve: Interval(begin, end, curve: curve),
    ).value;

    return value.clamp(0.0, 1.0).toDouble();
  }

  void _continue() {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        reverseTransitionDuration: const Duration(milliseconds: 550),
        pageBuilder: (_, animation, __) => LoginPage(language: language),
        transitionsBuilder: (_, animation, __, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          );

          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.035),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE9DC),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final logo = _animate(0.0, 0.38, curve: Curves.easeOutBack);

          final heading = _animate(0.14, 0.48);

          final cards = _animate(0.28, 0.65);

          final button = _animate(0.48, 0.80);

          return Stack(
            fit: StackFit.expand,
            children: [
              const _LanguageBackground(),

              IgnorePointer(
                child: CustomPaint(
                  painter: _LanguageParticlesPainter(
                    progress: _controller.value,
                  ),
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    children: [
                      const Spacer(),

                      // ------------------------------------------------
                      // LOGO
                      // ------------------------------------------------
                      Opacity(
                        opacity: logo,
                        child: Transform.translate(
                          offset: Offset(0, 18 * (1 - logo)),
                          child: Transform.scale(
                            scale: 0.84 + (logo * 0.16),
                            child: const _LanguageLeafLogo(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ------------------------------------------------
                      // HEADING
                      // ------------------------------------------------
                      Opacity(
                        opacity: heading,
                        child: Transform.translate(
                          offset: Offset(0, 16 * (1 - heading)),
                          child: Column(
                            children: [
                              Text(
                                'Welcome to',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF60705F),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.1,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                'NabhKrishi',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF205C43),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.9,
                                ),
                              ),

                              const SizedBox(height: 9),

                              Text(
                                'Sky to Soil Intelligence',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF71806D),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                'Choose your preferred language',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF667366),
                                  fontSize: 12,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 38),

                      // ------------------------------------------------
                      // LANGUAGE OPTIONS
                      // ------------------------------------------------
                      Opacity(
                        opacity: cards,
                        child: Transform.translate(
                          offset: Offset(0, 22 * (1 - cards)),
                          child: Column(
                            children: [
                              _LanguageOption(
                                title: 'English',
                                subtitle: 'Continue in English',
                                symbol: 'EN',
                                selected: language == 'English',
                                onTap: () {
                                  setState(() {
                                    language = 'English';
                                  });
                                },
                              ),

                              const SizedBox(height: 14),

                              _LanguageOption(
                                title: 'हिन्दी',
                                subtitle: 'हिन्दी में जारी रखें',
                                symbol: 'हि',
                                selected: language == 'Hindi',
                                onTap: () {
                                  setState(() {
                                    language = 'Hindi';
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ------------------------------------------------
                      // CONTINUE BUTTON
                      // ------------------------------------------------
                      Opacity(
                        opacity: button,
                        child: Transform.translate(
                          offset: Offset(0, 16 * (1 - button)),
                          child: _ContinueButton(
                            language: language,
                            onPressed: _continue,
                          ),
                        ),
                      ),

                      const Spacer(),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Text(
                          'You can change this later',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF7C8778),
                            fontSize: 10,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
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

// ═══════════════════════════════════════════════════════════════════════
// BACKGROUND
// ═══════════════════════════════════════════════════════════════════════

class _LanguageBackground extends StatelessWidget {
  const _LanguageBackground();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFDCE8D1),
            Color(0xFFECE9DC),
            Color(0xFFF0EDE1),
            Color(0xFFDDE8D3),
          ],
          stops: [0.0, 0.38, 0.72, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -150,
            top: -150,
            child: _SoftOrb(size: 380, color: const Color(0xFF789D68)),
          ),
          Positioned(
            right: -170,
            bottom: -170,
            child: _SoftOrb(size: 430, color: const Color(0xFF6C945D)),
          ),
        ],
      ),
    );
  }
}

class _SoftOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _SoftOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.035),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.055),
            blurRadius: 100,
            spreadRadius: 25,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// SUBTLE PARTICLES
// ═══════════════════════════════════════════════════════════════════════

class _LanguageParticlesPainter extends CustomPainter {
  final double progress;

  _LanguageParticlesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final random = math.Random(19);

    for (int i = 0; i < 28; i++) {
      final x = random.nextDouble() * size.width;

      final baseY = random.nextDouble() * size.height;

      final y = baseY + math.sin(progress * math.pi * 2 + i) * 5;

      final opacity =
          0.035 + (0.035 * ((math.sin(progress * math.pi * 2 + i) + 1) / 2));

      paint.color = const Color(0xFF527C57).withValues(alpha: opacity);

      canvas.drawCircle(Offset(x, y), i % 4 == 0 ? 1.1 : 0.7, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LanguageParticlesPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// ═══════════════════════════════════════════════════════════════════════
// LEAF LOGO
// ═══════════════════════════════════════════════════════════════════════

class _LanguageLeafLogo extends StatelessWidget {
  const _LanguageLeafLogo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 104,
      height: 104,
      child: CustomPaint(painter: _LanguageLeafPainter()),
    );
  }
}

class _LanguageLeafPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final glow = Paint()
      ..color = const Color(0xFF78B957).withValues(alpha: 0.07)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    canvas.drawCircle(center, 40, glow);

    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFF205C43).withValues(alpha: 0.15);

    canvas.drawCircle(center, 43, ring);

    final leaf = Path()
      ..moveTo(center.dx - 5, center.dy + 28)
      ..cubicTo(
        center.dx - 31,
        center.dy + 11,
        center.dx - 25,
        center.dy - 18,
        center.dx + 23,
        center.dy - 29,
      )
      ..cubicTo(
        center.dx + 32,
        center.dy - 6,
        center.dx + 18,
        center.dy + 19,
        center.dx - 5,
        center.dy + 28,
      )
      ..close();

    final leafPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Color(0xFFE0EBD1), Color(0xFF9BC486), Color(0xFF5E9B58)],
      ).createShader(Rect.fromCenter(center: center, width: 68, height: 68));

    canvas.drawPath(leaf, leafPaint);

    final vein = Path()
      ..moveTo(center.dx - 7, center.dy + 23)
      ..cubicTo(
        center.dx + 1,
        center.dy + 7,
        center.dx + 10,
        center.dy - 9,
        center.dx + 21,
        center.dy - 22,
      );

    final veinPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF205C43).withValues(alpha: 0.75);

    canvas.drawPath(vein, veinPaint);
  }

  @override
  bool shouldRepaint(covariant _LanguageLeafPainter oldDelegate) {
    return false;
  }
}

// ═══════════════════════════════════════════════════════════════════════
// LANGUAGE OPTION
// ═══════════════════════════════════════════════════════════════════════

class _LanguageOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final String symbol;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.subtitle,
    required this.symbol,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE5EFDC) : const Color(0xFFF3F0E5),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected
                ? const Color(0xFF6E9B60).withValues(alpha: 0.55)
                : const Color(0xFF205C43).withValues(alpha: 0.08),
            width: selected ? 1.3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(
                0xFF205C43,
              ).withValues(alpha: selected ? 0.09 : 0.045),
              blurRadius: selected ? 20 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? const Color(0xFF205C43)
                    : const Color(0xFFDCE7D2),
              ),
              alignment: Alignment.center,
              child: Text(
                symbol,
                style: GoogleFonts.poppins(
                  color: selected ? Colors.white : const Color(0xFF50704F),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF205C43),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF758074),
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? const Color(0xFF5E9B58)
                      : const Color(0xFF82907E),
                  width: 1.5,
                ),
              ),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 220),
                scale: selected ? 1 : 0,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF5E9B58),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// CONTINUE BUTTON
// ═══════════════════════════════════════════════════════════════════════

class _ContinueButton extends StatelessWidget {
  final String language;
  final VoidCallback onPressed;

  const _ContinueButton({required this.language, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isHindi = language == 'Hindi';

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFF205C43),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(19),
          ),
          shadowColor: const Color(0xFF205C43).withValues(alpha: 0.22),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isHindi ? 'आगे बढ़ें' : 'Continue',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1,
              ),
            ),
            const SizedBox(width: 9),
            const Icon(Icons.arrow_forward_rounded, size: 19),
          ],
        ),
      ),
    );
  }
}
