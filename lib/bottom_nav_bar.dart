import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'home_screen.dart';
import 'trips_screen.dart';
import 'profile_screen.dart';

class SharedBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const SharedBottomNavBar({super.key, required this.currentIndex});

  void _onTabTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget targetScreen;
    switch (index) {
      case 0:
        targetScreen = const HomeScreen();
        break;
      case 1:
        targetScreen = const TripsScreen();
        break;
      case 2:
        // History screen not implemented yet
        return;
      case 3:
        targetScreen = const ProfileScreen();
        break;
      default:
        return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => targetScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curve = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.05),
              end: Offset.zero,
            ).animate(curve),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curve),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            border: const Border(top: BorderSide(color: AppTheme.slate200)),
          ),
          padding: EdgeInsets.only(left: 24, right: 24, top: 12, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                icon: Icons.home_filled,
                label: 'Home',
                isSelected: currentIndex == 0,
                onTap: () => _onTabTapped(context, 0),
              ),
              _buildNavItem(
                icon: Icons.directions_car,
                label: 'Trips',
                isSelected: currentIndex == 1,
                onTap: () => _onTabTapped(context, 1),
              ),
              _buildNavItem(
                icon: Icons.history,
                label: 'History',
                isSelected: currentIndex == 2,
                onTap: () => _onTabTapped(context, 2),
              ),
              _buildNavItem(
                icon: Icons.person,
                label: 'Profile',
                isSelected: currentIndex == 3,
                onTap: () => _onTabTapped(context, 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    VoidCallback? onTap,
  }) {
    final color = isSelected ? AppTheme.primary : AppTheme.slate500;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
