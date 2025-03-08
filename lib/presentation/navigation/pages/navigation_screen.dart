import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trivytech/core/configs/assets/app_images.dart';
import 'package:trivytech/core/configs/themes/app_colors.dart';
import 'package:trivytech/presentation/ginie/pages/ginie_page.dart';
import 'package:trivytech/presentation/payment/pages/payment_page.dart';

import '../../home/page/home_page.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 1;
  final PageController _pageController = PageController(initialPage: 1);
  final List<Widget> _pages = [HomePage(), PaymentPage(), GiniePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(double.infinity, 120),
            painter: CurvedPainter(),
          ),
          Positioned(
            bottom: 20,
            left: 60,
            child: _buildNavItem(
              iconPath: AppImages.homeIcon,
              iconSize: 8,
              index: 0,
              label: "home",
              labelSize: 12,
            ),
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: _buildNavItem(
              iconPath: AppImages.scanIcon,
              iconSize: 12,
              index: 1,
              label: "yolo pay",
              labelSize: 16,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 60,
            child: _buildNavItem(
              iconPath: AppImages.ginieIcon,
              iconSize: 8,
              index: 2,
              label: "ginie",
              labelSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String iconPath,
    required String label,
    required double labelSize,
    required int index,
    required double iconSize,
  }) {
    return GestureDetector(
      onTap: () => setState(() {
        _currentIndex = index;
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: _currentIndex == index
                    ? [
                        Colors.white,
                        Colors.white.withAlpha(1),
                      ]
                    : [
                        Colors.grey.shade700,
                        Colors.grey.shade700.withAlpha(1),
                      ],
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.all(1),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppColors.darkbackground,
              ),
              padding: EdgeInsets.all(iconSize),
              child: SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                    _currentIndex == index
                        ? Colors.white
                        : Colors.grey.shade700,
                    BlendMode.srcIn),
              ),
            ),
          ),
          Text(label,
              style: TextStyle(
                color: _currentIndex == index
                    ? Colors.white
                    : Colors.grey.shade700,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.17,
                fontSize: labelSize,
              )),
        ],
      ),
    );
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint fillPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;

    Path fillPath = Path();

    fillPath.moveTo(0, 40);

    fillPath.quadraticBezierTo(size.width / 2, -30, size.width, 40);

    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);

    Path borderPath = Path();
    borderPath.moveTo(0, 40);
    borderPath.quadraticBezierTo(size.width / 2, -30, size.width, 40);

    Rect gradientRect = Rect.fromLTWH(0, -30, size.width, 70);
    Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = LinearGradient(
        colors: [Colors.white, Colors.black],
        begin: Alignment.center,
        end: Alignment.bottomCenter,
      ).createShader(gradientRect);

    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
