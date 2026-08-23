import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final String language;
  final String farmerName;
  final int streakDays;

  const HomePage({
    super.key,
    required this.language,
    this.farmerName = '',
    this.streakDays = 1,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int selectedIndex = 0;

  late final AnimationController _backgroundController;
  late final AnimationController _scoreController;

  bool get isHindi => widget.language == 'Hindi';

  @override
  void initState() {
    super.initState();

    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();

    _scoreController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _scoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F1E5),
      body: Stack(
        children: [
          Positioned.fill(
            child: _NatureBackground(controller: _backgroundController),
          ),

          SafeArea(
            bottom: false,
            child: IndexedStack(
              index: selectedIndex,
              children: [
                _HomeDashboard(
                  isHindi: isHindi,
                  farmerName: widget.farmerName,
                  streakDays: widget.streakDays,
                  scoreController: _scoreController,
                  onAskNabh: () {},
                  onCheckCrop: () {},
                ),
                _SecondaryPage(
                  icon: Icons.insights_rounded,
                  title: isHindi ? 'खेती की जानकारी' : 'Farm insights',
                  subtitle: isHindi
                      ? 'आपके खेत की स्थिति और बदलाव यहाँ दिखाई देंगे।'
                      : 'Your farm patterns and changes will appear here.',
                  isHindi: isHindi,
                ),
                _SecondaryPage(
                  icon: Icons.agriculture_rounded,
                  title: isHindi ? 'मेरा खेत' : 'My farm',
                  subtitle: isHindi
                      ? 'अपनी फसल और खेत की जानकारी देखें।'
                      : 'Keep your crops and fields organised here.',
                  isHindi: isHindi,
                ),
                _SecondaryPage(
                  icon: Icons.person_outline_rounded,
                  title: isHindi ? 'प्रोफ़ाइल' : 'Profile',
                  subtitle: isHindi
                      ? 'अपनी NabhKrishi जानकारी देखें।'
                      : 'Your NabhKrishi profile.',
                  isHindi: isHindi,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _BottomNavigation(
        selectedIndex: selectedIndex,
        isHindi: isHindi,
        onChanged: (index) {
          HapticFeedback.selectionClick();
          setState(() => selectedIndex = index);
        },
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* HOME DASHBOARD                                                             */
/* -------------------------------------------------------------------------- */

class _HomeDashboard extends StatelessWidget {
  final bool isHindi;
  final String farmerName;
  final int streakDays;
  final AnimationController scoreController;
  final VoidCallback onAskNabh;
  final VoidCallback onCheckCrop;

  const _HomeDashboard({
    required this.isHindi,
    required this.farmerName,
    required this.streakDays,
    required this.scoreController,
    required this.onAskNabh,
    required this.onCheckCrop,
  });

  static const background = Color(0xFFF4F1E5);
  static const paper = Color(0xFFFFFCF2);
  static const green = Color(0xFF205C43);
  static const darkGreen = Color(0xFF123E2D);
  static const leaf = Color(0xFF78B957);
  static const paleLeaf = Color(0xFFDCEBC9);
  static const muted = Color(0xFF6D7B6C);
  static const yellow = Color(0xFFE8BD55);

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return isHindi ? 'सुप्रभात' : 'Good morning';
    }

    if (hour < 17) {
      return isHindi ? 'नमस्ते' : 'Good afternoon';
    }

    return isHindi ? 'शुभ संध्या' : 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final name = farmerName.trim().isEmpty
        ? (isHindi ? 'किसान' : 'friend')
        : farmerName.trim();

    return Container(
      color: background,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 120),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _Header(name: name, greeting: _greeting()),

                const SizedBox(height: 28),

                Text(
                  isHindi
                      ? 'आपके खेत की\nआज की कहानी।'
                      : 'A quiet look at\nhow your farm is doing.',
                  style: GoogleFonts.fraunces(
                    color: darkGreen,
                    fontSize: 35,
                    height: 1.02,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  isHindi
                      ? 'ज़रूरी बातें एक जगह — बिना किसी उलझन के।'
                      : 'The important things, together and easy to understand.',
                  style: GoogleFonts.poppins(
                    color: muted,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 25),

                _FarmStatus(isHindi: isHindi, controller: scoreController),

                const SizedBox(height: 14),

                _WeatherRow(isHindi: isHindi),

                const SizedBox(height: 20),

                _Attention(isHindi: isHindi),

                const SizedBox(height: 28),

                Text(
                  isHindi ? 'आज क्या करना है?' : 'What do you need today?',
                  style: GoogleFonts.fraunces(
                    color: darkGreen,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 13),

                _ActionGrid(
                  isHindi: isHindi,
                  onAskNabh: onAskNabh,
                  onCheckCrop: onCheckCrop,
                ),

                const SizedBox(height: 18),

                _NabhCard(isHindi: isHindi, onTap: onAskNabh),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* HEADER                                                                     */
/* -------------------------------------------------------------------------- */

class _Header extends StatelessWidget {
  final String name;
  final String greeting;

  const _Header({required this.name, required this.greeting});

  static const green = Color(0xFF205C43);
  static const paper = Color(0xFFFFFCF2);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(color: green, shape: BoxShape.circle),
          child: const Icon(
            Icons.eco_rounded,
            color: Color(0xFFF4F1E5),
            size: 23,
          ),
        ),

        const SizedBox(width: 11),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NabhKrishi',
                style: GoogleFonts.poppins(
                  color: green,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '$greeting, $name',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF718072),
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ),

        _HeaderButton(icon: Icons.notifications_none_rounded, onTap: () {}),

        const SizedBox(width: 7),

        _HeaderButton(icon: Icons.person_outline_rounded, onTap: () {}),
      ],
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFCF2),
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF205C43).withValues(alpha: 0.08),
          ),
        ),
        child: Icon(icon, color: const Color(0xFF205C43), size: 20),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* FARM STATUS                                                                */
/* -------------------------------------------------------------------------- */

class _FarmStatus extends StatelessWidget {
  final bool isHindi;
  final AnimationController controller;

  const _FarmStatus({required this.isHindi, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final progress = Curves.easeOutCubic
            .transform(controller.value)
            .clamp(0.0, 1.0);

        const score = 82;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF205C43),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 108,
                    height: 108,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 104,
                          height: 104,
                          child: CircularProgressIndicator(
                            value: progress * 0.82,
                            strokeWidth: 7,
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.10,
                            ),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFBCE39A),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${(score * progress).round()}',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 30,
                                height: 1,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              isHindi ? 'अच्छा' : 'GOOD',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFFBCE39A),
                                fontSize: 8,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 19),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHindi ? 'आज खेत की स्थिति' : 'TODAY ON YOUR FARM',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFBCE39A),
                            fontSize: 8,
                            letterSpacing: 0.9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          isHindi
                              ? 'सब कुछ\nठीक चल रहा है।'
                              : 'Everything is\nlooking healthy.',
                          style: GoogleFonts.fraunces(
                            color: Colors.white,
                            fontSize: 24,
                            height: 1.05,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 9),

                        Text(
                          isHindi
                              ? 'मिट्टी और फसल के संकेत सामान्य हैं।'
                              : 'Your soil and crop signals look normal.',
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.62),
                            fontSize: 9,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 19),

              Container(height: 1, color: Colors.white.withValues(alpha: 0.09)),

              const SizedBox(height: 14),

              Row(
                children: [
                  _StatusItem(
                    icon: Icons.water_drop_outlined,
                    text: isHindi ? 'पानी ठीक' : 'Water okay',
                  ),
                  _StatusItem(
                    icon: Icons.spa_outlined,
                    text: isHindi ? 'फसल अच्छी' : 'Crop good',
                  ),
                  _StatusItem(
                    icon: Icons.thermostat_outlined,
                    text: isHindi ? 'मौसम ठीक' : 'Weather okay',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatusItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _StatusItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFBCE39A), size: 15),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                color: Colors.white.withValues(alpha: 0.65),
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* WEATHER                                                                    */
/* -------------------------------------------------------------------------- */

class _WeatherRow extends StatelessWidget {
  final bool isHindi;

  const _WeatherRow({required this.isHindi});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF2),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFF205C43).withValues(alpha: 0.07),
        ),
      ),
      child: Row(
        children: [
          _WeatherMetric(
            icon: Icons.wb_sunny_rounded,
            value: '27°',
            label: isHindi ? 'गर्म' : 'Warm',
            color: const Color(0xFFE1B84E),
          ),
          _WeatherDivider(),
          _WeatherMetric(
            icon: Icons.water_drop_rounded,
            value: '72%',
            label: isHindi ? 'नमी' : 'Humidity',
            color: const Color(0xFF73AFC0),
          ),
          _WeatherDivider(),
          _WeatherMetric(
            icon: Icons.air_rounded,
            value: '12',
            label: isHindi ? 'हवा km/h' : 'km/h breeze',
            color: const Color(0xFF82A99F),
          ),
        ],
      ),
    );
  }
}

class _WeatherMetric extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _WeatherMetric({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF173D30),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF738075),
                    fontSize: 7.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 34,
      margin: const EdgeInsets.symmetric(horizontal: 7),
      color: const Color(0xFF205C43).withValues(alpha: 0.08),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* ATTENTION                                                                  */
/* -------------------------------------------------------------------------- */

class _Attention extends StatelessWidget {
  final bool isHindi;

  const _Attention({required this.isHindi});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3D7),
        borderRadius: BorderRadius.circular(23),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Color(0xFFFFE5A3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.water_drop_outlined,
              color: Color(0xFFAA7B1B),
              size: 22,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isHindi
                      ? 'थोड़ा पानी देना अच्छा रहेगा'
                      : 'Your field may need some water',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF4A412C),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  isHindi
                      ? 'आज शाम मौसम थोड़ा गर्म हो सकता है।'
                      : 'The evening may be warmer than usual.',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF8B8065),
                    fontSize: 8.5,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_rounded,
            color: Color(0xFFAA7B1B),
            size: 17,
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* ACTIONS                                                                    */
/* -------------------------------------------------------------------------- */
class _ActionGrid extends StatelessWidget {
  final bool isHindi;
  final VoidCallback onAskNabh;
  final VoidCallback onCheckCrop;

  const _ActionGrid({
    required this.isHindi,
    required this.onAskNabh,
    required this.onCheckCrop,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _FarmAction(
                icon: Icons.graphic_eq_rounded,
                title: isHindi ? 'नभ से पूछें' : 'Ask Nabh',
                subtitle: isHindi
                    ? 'खेती के बारे में पूछें'
                    : 'Ask about your farm',
                accent: const Color(0xFF205C43),
                large: true,
                onTap: onAskNabh,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _FarmAction(
                icon: Icons.camera_alt_outlined,
                title: isHindi ? 'फसल देखें' : 'Check crop',
                subtitle: isHindi
                    ? 'तस्वीर से जाँच करें'
                    : 'Check with a photo',
                accent: const Color(0xFF6D9B55),
                large: true,
                onTap: onCheckCrop,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _FarmAction(
                icon: Icons.wb_sunny_outlined,
                title: isHindi ? 'मौसम' : 'Weather',
                subtitle: isHindi ? 'आज और कल' : 'Today & tomorrow',
                accent: const Color(0xFFC49A3A),
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _FarmAction(
                icon: Icons.landscape_outlined,
                title: isHindi ? 'मेरा खेत' : 'My farm',
                subtitle: isHindi ? 'अपनी ज़मीन देखें' : 'View your fields',
                accent: const Color(0xFF527C57),
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FarmAction extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final VoidCallback onTap;
  final bool large;

  const _FarmAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.onTap,
    this.large = false,
  });

  @override
  State<_FarmAction> createState() => _FarmActionState();
}

class _FarmActionState extends State<_FarmAction> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => pressed = true);
      },
      onTapCancel: () {
        setState(() => pressed = false);
      },
      onTapUp: (_) {
        setState(() => pressed = false);
        widget.onTap();
      },
      child: AnimatedScale(
        scale: pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          height: widget.large ? 142 : 125,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF2),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: widget.accent.withValues(alpha: 0.10)),
            boxShadow: [
              BoxShadow(
                color: widget.accent.withValues(alpha: pressed ? 0.10 : 0.045),
                blurRadius: pressed ? 12 : 20,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Very subtle decorative circle.
              Positioned(
                right: -22,
                top: -25,
                child: Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.accent.withValues(alpha: 0.045),
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: widget.accent.withValues(alpha: 0.11),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(widget.icon, color: widget.accent, size: 21),
                  ),

                  const Spacer(),

                  Text(
                    widget.title,
                    style: GoogleFonts.fraunces(
                      color: const Color(0xFF173D30),
                      fontSize: 17,
                      height: 1.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF738075),
                            fontSize: 8,
                          ),
                        ),
                      ),

                      const SizedBox(width: 5),

                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: widget.accent.withValues(alpha: 0.09),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: widget.accent,
                          size: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* NABH CARD                                                                  */
/* -------------------------------------------------------------------------- */

class _NabhCard extends StatelessWidget {
  final bool isHindi;
  final VoidCallback onTap;

  const _NabhCard({required this.isHindi, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFDCEBC9),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 15, 15, 15),
          child: Row(
            children: [
              Container(
                width: 47,
                height: 47,
                decoration: const BoxDecoration(
                  color: Color(0xFF205C43),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  color: Color(0xFFE9F2D8),
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isHindi ? 'नभ आपके साथ है' : 'Nabh is here',
                      style: GoogleFonts.fraunces(
                        color: const Color(0xFF173D30),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isHindi
                          ? 'खेती, फसल या मौसम के बारे में पूछें।'
                          : 'Ask about your farm, crops or weather.',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF647663),
                        fontSize: 8.5,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: 43,
                height: 43,
                decoration: const BoxDecoration(
                  color: Color(0xFF205C43),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.graphic_eq_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* SECONDARY PAGES                                                            */
/* -------------------------------------------------------------------------- */

class _SecondaryPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isHindi;

  const _SecondaryPage({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isHindi,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4F1E5),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 35, 22, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFF205C43),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: const Color(0xFFF4F1E5), size: 27),
              ),

              const SizedBox(height: 22),

              Text(
                title,
                style: GoogleFonts.fraunces(
                  color: const Color(0xFF173D30),
                  fontSize: 34,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF6D7B6C),
                  fontSize: 12,
                  height: 1.55,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFCF2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.eco_outlined,
                      color: Color(0xFF78B957),
                      size: 28,
                    ),
                    const SizedBox(width: 13),
                    Expanded(
                      child: Text(
                        isHindi
                            ? 'यह हिस्सा जल्द ही आपकी खेती की जानकारी दिखाएगा।'
                            : 'This space will grow with your farm data.',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF526454),
                          fontSize: 10,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* BOTTOM NAVIGATION                                                          */
/* -------------------------------------------------------------------------- */

class _BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final bool isHindi;
  final ValueChanged<int> onChanged;

  const _BottomNavigation({
    required this.selectedIndex,
    required this.isHindi,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.home_rounded, isHindi ? 'होम' : 'Home'),
      (Icons.insights_rounded, isHindi ? 'जानकारी' : 'Insights'),
      (Icons.agriculture_rounded, isHindi ? 'खेत' : 'Farm'),
      (Icons.person_outline_rounded, isHindi ? 'प्रोफ़ाइल' : 'Profile'),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 11),
        child: Container(
          height: 66,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFF173F30),
            borderRadius: BorderRadius.circular(23),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF173F30).withValues(alpha: 0.18),
                blurRadius: 20,
                offset: const Offset(0, 7),
              ),
            ],
          ),
          child: Row(
            children: List.generate(items.length, (index) {
              final selected = selectedIndex == index;

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onChanged(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xFF78B957).withValues(alpha: 0.18)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          items[index].$1,
                          color: selected
                              ? const Color(0xFFBCE39A)
                              : Colors.white.withValues(alpha: 0.48),
                          size: 20,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          items[index].$2,
                          style: GoogleFonts.poppins(
                            color: selected
                                ? const Color(0xFFBCE39A)
                                : Colors.white.withValues(alpha: 0.48),
                            fontSize: 7.5,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* BACKGROUND                                                                 */
/* -------------------------------------------------------------------------- */

class _NatureBackground extends StatelessWidget {
  final AnimationController controller;

  const _NatureBackground({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final value = controller.value;

        return CustomPaint(painter: _NaturePainter(value), size: Size.infinite);
      },
    );
  }
}

class _NaturePainter extends CustomPainter {
  final double t;

  _NaturePainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE7F0DA), Color(0xFFF4F1E5), Color(0xFFF4F1E5)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), base);

    final radius = size.width * 0.55;

    final x1 = size.width * 0.82 + math.sin(t * math.pi * 2) * 18;

    final glow1 = Paint()
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFFB8D99B).withValues(alpha: 0.22),
              const Color(0xFFB8D99B).withValues(alpha: 0),
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(x1, size.height * 0.08),
              radius: radius,
            ),
          );

    canvas.drawCircle(Offset(x1, size.height * 0.08), radius, glow1);

    final x2 = size.width * 0.05 + math.cos(t * math.pi * 2) * 15;

    final glow2 = Paint()
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFFBFDCA7).withValues(alpha: 0.12),
              const Color(0xFFBFDCA7).withValues(alpha: 0),
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(x2, size.height * 0.68),
              radius: radius * 0.9,
            ),
          );

    canvas.drawCircle(Offset(x2, size.height * 0.68), radius * 0.9, glow2);
  }

  @override
  bool shouldRepaint(covariant _NaturePainter oldDelegate) {
    return oldDelegate.t != t;
  }
}
