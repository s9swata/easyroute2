import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'create_roster_screen.dart'; // ADDITION ONLY — existing code unchanged
import 'trips_screen.dart'; // ADDITION ONLY — existing code unchanged
import 'bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      extendBody: true,
      bottomNavigationBar: const SharedBottomNavBar(currentIndex: 0),
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 56.0 + 24.0, // Reduced from 48.0 to bring content higher
              left: 16.0,
              right: 16.0,
              bottom: 260.0, // extra padding for bottom AI box + nav
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroSection(),
                    const SizedBox(height: 16.0), // Reduced from 24.0
                    _buildQuickActions(
                      context,
                    ), // ADDITION ONLY — pass context for navigation
                  ],
                ),
              ),
            ),
          ),

          // Central AI Agent Textbox (Fixed near bottom)
          Positioned(
            bottom:
                12, // Reduced from 60 because bottomNavigationBar manages its own space now
            left: 0,
            right: 0,
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: _buildAITextBox(),
                ),
              ),
            ),
          ),

          // Top Header (Sticky)
          Positioned(top: 0, left: 0, right: 0, child: _buildHeader(context)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          color: AppTheme.backgroundLight.withValues(alpha: 0.8),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo & Title
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.route_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'EasyRoute',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                          color: AppTheme.slate900,
                        ),
                      ),
                    ],
                  ),
                  // Actions & Avatar
                  Row(
                    children: [
                      _buildIconButton(Icons.history),
                      const SizedBox(width: 8),
                      _buildIconButton(Icons.settings_outlined),
                      const SizedBox(width: 12), // ml-1 + gap
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.primary.withValues(alpha: 0.2),
                            width: 2,
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/profile.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        hoverColor: AppTheme.slate200,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: AppTheme.slate900, size: 24),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppTheme.primary, AppTheme.blue400],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(bounds),
          child: const Text(
            'Hello, Alex',
            style: TextStyle(
              fontSize: 36, // Reduced from 48
              fontWeight: FontWeight.w600,
              letterSpacing: -1.0,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 8), // Reduced from 16
        const Text(
          'Ready to optimize your corporate travel today?',
          style: TextStyle(
            fontSize: 18, // Slightly reduced from 20
            color: AppTheme.slate500,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // ADDITION ONLY — existing code unchanged
  void _navigateToTrips(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const TripsScreen(),
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

  // ADDITION ONLY — existing code unchanged (method added for custom navigation)
  void _navigateToCreateRoster(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CreateRosterScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curve = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.05), // Cinematic slight slide up
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

  Widget _buildQuickActions(BuildContext context) {
    // ADDITION ONLY — accepted context
    return Column(
      children: [
        // ADDITION ONLY — existing code unchanged (wrapped in GestureDetector)
        GestureDetector(
          onTap: () => _navigateToCreateRoster(context),
          child: _buildActionTile(
            icon: Icons.edit_calendar_outlined,
            title: 'Create Roster',
            subtitle: 'Generate new employee schedules',
          ),
        ),
        const SizedBox(height: 8),
        _buildActionTile(
          icon: Icons.analytics_outlined,
          title: 'View Stats',
          subtitle: 'Analyze travel costs and efficiency',
        ),
        const SizedBox(height: 8),
        GestureDetector(
          // ADDITION ONLY
          onTap: () => _navigateToTrips(context), // ADDITION ONLY
          child: _buildActionTile(
            icon: Icons.explore_outlined,
            title: 'Explore Trips',
            subtitle: 'Discover best routes and stays',
          ),
        ),
      ],
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ), // Reduced vertical padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        border: Border.all(color: AppTheme.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12), // rounded-xl
            ),
            child: Icon(icon, color: AppTheme.primary, size: 24),
          ),
          const SizedBox(width: 16), // Replaced vertical gap with horizontal
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16, // Slightly reduced font size
                    fontWeight: FontWeight.w600,
                    color: AppTheme.slate900,
                  ),
                ),
                const SizedBox(height: 2), // Tighter gap
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12, // Slightly reduced font size
                    color: AppTheme.slate500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAITextBox() {
    return Container(
      color: AppTheme.backgroundLight,
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ), // Reduced vertical from 16
      child: Column(
        children: [
          // Main Input Box
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.slate200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 20),
                  blurRadius: 25,
                  spreadRadius: -5,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 8),
                  blurRadius: 10,
                  spreadRadius: -6,
                ),
              ],
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const TextField(
                  maxLines: 3, // Reduced from 4
                  minLines: 2, // Reduced from 3
                  style: TextStyle(fontSize: 18, color: AppTheme.slate900),
                  decoration: InputDecoration(
                    hintText: 'How can I help you today?',
                    hintStyle: TextStyle(color: AppTheme.slate400),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _buildToolIcon(Icons.image_outlined),
                          const SizedBox(width: 4),
                          _buildToolIcon(Icons.mic_none_outlined),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // Smaller radius
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 16,
                          ), // Arrow icon & smaller size
                          onPressed: () {},
                          padding: const EdgeInsets.all(
                            4,
                          ), // Even smaller padding
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8), // Reduced from 16
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'EasyRoute AI may provide inaccurate travel information. Check important flight and hotel details.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12, // Slightly increased from 10
                color: AppTheme.slate500, // Better contrast
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolIcon(IconData icon) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon, color: AppTheme.slate500),
        ),
      ),
    );
  }
}
