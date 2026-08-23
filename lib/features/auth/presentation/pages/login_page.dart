import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../home/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  final String language;

  const LoginPage({super.key, required this.language});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _otpController = TextEditingController();

  late final AnimationController _animationController;

  bool _showOtp = false;
  bool _loading = false;
  String? _error;

  bool get isHindi => widget.language == 'Hindi';

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..forward();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _continue() {
    FocusScope.of(context).unfocus();

    final phone = _phoneController.text.trim();

    if (phone.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(phone)) {
      setState(() {
        _error = isHindi
            ? 'कृपया 10 अंकों का मोबाइल नंबर दर्ज करें।'
            : 'Please enter a valid 10-digit mobile number.';
      });
      return;
    }

    setState(() {
      _error = null;
      _loading = true;
    });

    Future.delayed(const Duration(milliseconds: 650), () {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _showOtp = true;
      });
    });
  }

  void _verifyOtp() {
    FocusScope.of(context).unfocus();

    final otp = _otpController.text.trim();

    if (otp.length != 6 || !RegExp(r'^[0-9]+$').hasMatch(otp)) {
      setState(() {
        _error = isHindi
            ? 'कृपया 6 अंकों का OTP दर्ज करें।'
            : 'Please enter the 6-digit OTP.';
      });
      return;
    }

    setState(() {
      _error = null;
      _loading = true;
    });

    Future.delayed(const Duration(milliseconds: 750), () {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });

      _showSuccess();
    });
  }

  void _googleLogin() {
    setState(() {
      _error = null;
      _loading = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });

      _showSuccess();
    });
  }

  void _showSuccess() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: const Color(0xFF173D2E).withValues(alpha: 0.38),
      transitionDuration: const Duration(milliseconds: 420),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 25),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F0E5),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFF205C43).withValues(alpha: 0.10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF205C43).withValues(alpha: 0.16),
                      blurRadius: 40,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFDCEBD4),
                        border: Border.all(
                          color: const Color(
                            0xFF72A563,
                          ).withValues(alpha: 0.35),
                        ),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Color(0xFF205C43),
                        size: 38,
                      ),
                    ),

                    const SizedBox(height: 22),

                    Text(
                      isHindi ? 'सत्यापन सफल!' : 'Verification successful',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF205C43),
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      isHindi
                          ? 'अब आपकी खेती की दुनिया तैयार है।'
                          : 'Your NabhKrishi journey is ready.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF71806D),
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              transitionDuration: const Duration(
                                milliseconds: 650,
                              ),
                              pageBuilder: (_, animation, __) {
                                return HomePage(language: widget.language);
                              },
                              transitionsBuilder: (_, animation, __, child) {
                                final curved = CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.easeOutCubic,
                                );

                                return FadeTransition(
                                  opacity: curved,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 0.025),
                                      end: Offset.zero,
                                    ).animate(curved),
                                    child: child,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFF205C43),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                        child: Text(
                          isHindi ? 'आगे बढ़ें' : 'Continue',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );

        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.92, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE9DC),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (_, __) {
              return CustomPaint(
                size: Size.infinite,
                painter: _LoginBackgroundPainter(
                  progress: _animationController.value,
                ),
              );
            },
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BackButton(onPressed: () => Navigator.pop(context)),

                  const SizedBox(height: 30),

                  Center(
                    child: _AnimatedEntrance(
                      controller: _animationController,
                      begin: 0.0,
                      end: 0.38,
                      child: const _LoginLeafLogo(),
                    ),
                  ),

                  const SizedBox(height: 27),

                  _AnimatedEntrance(
                    controller: _animationController,
                    begin: 0.10,
                    end: 0.48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHindi
                              ? 'नाभकृषि में आपका स्वागत है'
                              : 'Welcome to NabhKrishi',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF205C43),
                            fontSize: 28,
                            height: 1.15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ),

                        const SizedBox(height: 9),

                        Text(
                          isHindi
                              ? 'आपकी खेती, हमारे साथ और स्मार्ट।'
                              : 'Your farm. Your future. Smarter.',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF667366),
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  _AnimatedEntrance(
                    controller: _animationController,
                    begin: 0.25,
                    end: 0.68,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      child: _showOtp
                          ? _OtpSection(
                              key: const ValueKey('otp'),
                              controller: _otpController,
                              phone: _phoneController.text,
                              isHindi: isHindi,
                              error: _error,
                              onVerify: _verifyOtp,
                              onChangeNumber: () {
                                setState(() {
                                  _showOtp = false;
                                  _otpController.clear();
                                  _error = null;
                                });
                              },
                            )
                          : _PhoneSection(
                              key: const ValueKey('phone'),
                              controller: _phoneController,
                              isHindi: isHindi,
                              error: _error,
                              onContinue: _continue,
                            ),
                    ),
                  ),

                  if (!_showOtp) ...[
                    const SizedBox(height: 22),

                    _AnimatedEntrance(
                      controller: _animationController,
                      begin: 0.45,
                      end: 0.78,
                      child: _GoogleButton(
                        isHindi: isHindi,
                        onPressed: _googleLogin,
                      ),
                    ),
                  ],

                  const SizedBox(height: 28),

                  Center(
                    child: Text(
                      isHindi
                          ? 'आपकी जानकारी सुरक्षित रखी जाती है।'
                          : 'Your information stays private and secure.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF7B857A),
                        fontSize: 9.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (_loading)
            Positioned.fill(
              child: Container(
                color: const Color(0xFFECE9DC).withValues(alpha: 0.62),
                child: const Center(child: _LoadingIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// PHONE SECTION
// ═══════════════════════════════════════════════════════════════════════

class _PhoneSection extends StatelessWidget {
  final TextEditingController controller;
  final bool isHindi;
  final String? error;
  final VoidCallback onContinue;

  const _PhoneSection({
    super.key,
    required this.controller,
    required this.isHindi,
    required this.error,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isHindi ? 'मोबाइल नंबर' : 'Mobile number',
          style: GoogleFonts.poppins(
            color: const Color(0xFF315B45),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 9),

        _PhoneField(controller: controller, isHindi: isHindi),

        if (error != null) ...[
          const SizedBox(height: 8),
          Text(
            error!,
            style: GoogleFonts.inter(
              color: const Color(0xFFB45F50),
              fontSize: 10,
            ),
          ),
        ],

        const SizedBox(height: 17),

        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: onContinue,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFF205C43),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isHindi ? 'OTP भेजें' : 'Send OTP',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// OTP SECTION
// ═══════════════════════════════════════════════════════════════════════

class _OtpSection extends StatelessWidget {
  final TextEditingController controller;
  final String phone;
  final bool isHindi;
  final String? error;
  final VoidCallback onVerify;
  final VoidCallback onChangeNumber;

  const _OtpSection({
    super.key,
    required this.controller,
    required this.phone,
    required this.isHindi,
    required this.error,
    required this.onVerify,
    required this.onChangeNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isHindi ? 'OTP सत्यापित करें' : 'Verify your number',
          style: GoogleFonts.poppins(
            color: const Color(0xFF205C43),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          isHindi
              ? 'आपके मोबाइल नंबर पर 6 अंकों का OTP भेजा गया है।'
              : 'We sent a 6-digit OTP to your mobile number.',
          style: GoogleFonts.inter(
            color: const Color(0xFF71806D),
            fontSize: 11,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          '+91 ${phone.replaceRange(0, math.max(0, phone.length - 4), '••••••')}',
          style: GoogleFonts.poppins(
            color: const Color(0xFF50704F),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 18),

        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          maxLength: 6,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: const Color(0xFF205C43),
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 8,
          ),
          decoration: InputDecoration(
            counterText: '',
            hintText: '••••••',
            hintStyle: GoogleFonts.poppins(
              color: const Color(0xFF879387),
              fontSize: 21,
              letterSpacing: 8,
            ),
            filled: true,
            fillColor: const Color(0xFFF3F0E5),
            contentPadding: const EdgeInsets.symmetric(vertical: 17),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: const Color(0xFF205C43).withValues(alpha: 0.08),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: const Color(0xFF205C43).withValues(alpha: 0.08),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(
                color: Color(0xFF5E9B58),
                width: 1.4,
              ),
            ),
          ),
        ),

        if (error != null) ...[
          const SizedBox(height: 7),
          Text(
            error!,
            style: GoogleFonts.inter(
              color: const Color(0xFFB45F50),
              fontSize: 10,
            ),
          ),
        ],

        const SizedBox(height: 15),

        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: onVerify,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFF205C43),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: Text(
              isHindi ? 'सत्यापित करें' : 'Verify OTP',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        Center(
          child: TextButton(
            onPressed: onChangeNumber,
            child: Text(
              isHindi ? 'नंबर बदलें' : 'Change number',
              style: GoogleFonts.inter(
                color: const Color(0xFF50704F),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// PHONE FIELD
// ═══════════════════════════════════════════════════════════════════════

class _PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final bool isHindi;

  const _PhoneField({required this.controller, required this.isHindi});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      style: GoogleFonts.poppins(
        color: const Color(0xFF205C43),
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
      ),
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: const Color(0xFFF3F0E5),
        hintText: isHindi
            ? '10 अंकों का मोबाइल नंबर'
            : '10-digit mobile number',
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF8A9388),
          fontSize: 11,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 17, right: 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🇮🇳', style: TextStyle(fontSize: 17)),
              const SizedBox(width: 8),
              Text(
                '+91',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF50704F),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 1,
                height: 22,
                color: const Color(0xFF205C43).withValues(alpha: 0.10),
              ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: const Color(0xFF205C43).withValues(alpha: 0.08),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: const Color(0xFF205C43).withValues(alpha: 0.08),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF5E9B58), width: 1.4),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// GOOGLE BUTTON
// ═══════════════════════════════════════════════════════════════════════

class _GoogleButton extends StatelessWidget {
  final bool isHindi;
  final VoidCallback onPressed;

  const _GoogleButton({required this.isHindi, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF315B45),
          backgroundColor: const Color(0xFFF3F0E5),
          side: BorderSide(
            color: const Color(0xFF205C43).withValues(alpha: 0.10),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                'G',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF4285F4),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              isHindi ? 'Google से जारी रखें' : 'Continue with Google',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// BACK BUTTON
// ═══════════════════════════════════════════════════════════════════════

class _BackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _BackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F0E5),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFF205C43).withValues(alpha: 0.08),
            ),
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF315B45),
            size: 20,
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// LOGO
// ═══════════════════════════════════════════════════════════════════════

class _LoginLeafLogo extends StatelessWidget {
  const _LoginLeafLogo();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 94,
      height: 94,
      child: CustomPaint(painter: _LoginLeafPainter()),
    );
  }
}

class _LoginLeafPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final glow = Paint()
      ..color = const Color(0xFF5E9B58).withValues(alpha: 0.06)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);

    canvas.drawCircle(center, 35, glow);

    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFF205C43).withValues(alpha: 0.12);

    canvas.drawCircle(center, 38, ring);

    final leaf = Path()
      ..moveTo(center.dx - 4, center.dy + 24)
      ..cubicTo(
        center.dx - 26,
        center.dy + 9,
        center.dx - 21,
        center.dy - 14,
        center.dx + 19,
        center.dy - 25,
      )
      ..cubicTo(
        center.dx + 27,
        center.dy - 5,
        center.dx + 15,
        center.dy + 17,
        center.dx - 4,
        center.dy + 24,
      )
      ..close();

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Color(0xFFBFD8A9), Color(0xFF79AC6B), Color(0xFF4F8A52)],
      ).createShader(Rect.fromCenter(center: center, width: 58, height: 58));

    canvas.drawPath(leaf, paint);

    final vein = Path()
      ..moveTo(center.dx - 6, center.dy + 20)
      ..cubicTo(
        center.dx + 1,
        center.dy + 5,
        center.dx + 10,
        center.dy - 10,
        center.dx + 18,
        center.dy - 19,
      );

    final veinPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFF205C43).withValues(alpha: 0.72);

    canvas.drawPath(vein, veinPaint);
  }

  @override
  bool shouldRepaint(covariant _LoginLeafPainter oldDelegate) {
    return false;
  }
}

// ═══════════════════════════════════════════════════════════════════════
// ENTRANCE ANIMATION
// ═══════════════════════════════════════════════════════════════════════

class _AnimatedEntrance extends StatelessWidget {
  final AnimationController controller;
  final double begin;
  final double end;
  final Widget child;

  const _AnimatedEntrance({
    required this.controller,
    required this.begin,
    required this.end,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        final value = animation.value.clamp(0.0, 1.0);

        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 18 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// LOADING
// ═══════════════════════════════════════════════════════════════════════

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0E5),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF205C43).withValues(alpha: 0.12),
            blurRadius: 25,
          ),
        ],
      ),
      child: const CircularProgressIndicator(
        strokeWidth: 2.2,
        color: Color(0xFF5E9B58),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════
// BACKGROUND PAINTER
// ═══════════════════════════════════════════════════════════════════════

class _LoginBackgroundPainter extends CustomPainter {
  final double progress;

  _LoginBackgroundPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final width = size.width;
    final height = size.height;

    // Soft top organic glow.
    paint.color = const Color(0xFF5E9B58).withValues(alpha: 0.045);

    canvas.drawCircle(Offset(width * 0.08, height * 0.12), 150, paint);

    // Soft bottom glow.
    paint.color = const Color(0xFF205C43).withValues(alpha: 0.035);

    canvas.drawCircle(Offset(width * 0.95, height * 0.88), 190, paint);

    // Very subtle curved lines.
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFF47734E).withValues(alpha: 0.045);

    for (int i = 0; i < 4; i++) {
      final path = Path();

      final y = height * (0.18 + i * 0.18);

      path.moveTo(-40, y);

      path.cubicTo(
        width * 0.25,
        y - 30,
        width * 0.70,
        y + 30,
        width + 40,
        y - 8,
      );

      canvas.drawPath(path, linePaint);
    }

    // Tiny floating dots.
    final dotPaint = Paint();

    for (int i = 0; i < 18; i++) {
      final x = (i * 73.0) % width;

      final baseY = (i * 117.0) % height;

      final y = baseY + math.sin(progress * math.pi * 2 + i) * 4;

      dotPaint.color = const Color(0xFF527C57).withValues(alpha: 0.045);

      canvas.drawCircle(Offset(x, y), i % 3 == 0 ? 1.2 : 0.7, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _LoginBackgroundPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
