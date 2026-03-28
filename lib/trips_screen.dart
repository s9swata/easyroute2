import 'package:flutter/material.dart';
import 'theme.dart';
import 'home_screen.dart';
import 'bottom_nav_bar.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  int _currentTab = 0; // 0: Ongoing, 1: Upcoming, 2: History

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      extendBody: true,
      bottomNavigationBar: const SharedBottomNavBar(currentIndex: 1),
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 130.0,
              bottom: 120.0 + MediaQuery.of(context).padding.bottom,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_currentTab == 0) ...[
                      _buildActiveTripSection(),
                      _buildOtherTripsSection(),
                    ],
                    if (_currentTab == 1) _buildUpcomingTabSection(),
                    if (_currentTab == 2) _buildHistoryTabSection(),
                  ],
                ),
              ),
            ),
          ),

          // Top Header (Sticky)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHeader(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppTheme.slate200),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            } else {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => const HomeScreen()),
                              );
                            }
                          },
                          child: const SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(Icons.arrow_back, color: AppTheme.slate900, size: 24),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          'My Trips',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.slate900,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.search, color: AppTheme.slate900, size: 24),
                      ),
                    ],
                  ),
                ),
                
                // Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _currentTab = 0),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: _currentTab == 0 ? AppTheme.primary : Colors.transparent, 
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: Text(
                            'Ongoing',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: _currentTab == 0 ? FontWeight.bold : FontWeight.w600,
                              color: _currentTab == 0 ? AppTheme.primary : AppTheme.slate500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                      GestureDetector(
                        onTap: () => setState(() => _currentTab = 1),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: _currentTab == 1 ? AppTheme.primary : Colors.transparent, 
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: Text(
                            'Upcoming',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: _currentTab == 1 ? FontWeight.bold : FontWeight.w600,
                              color: _currentTab == 1 ? AppTheme.primary : AppTheme.slate500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                      GestureDetector(
                        onTap: () => setState(() => _currentTab = 2),
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: _currentTab == 2 ? AppTheme.primary : Colors.transparent, 
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: Text(
                            'History',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: _currentTab == 2 ? FontWeight.bold : FontWeight.w600,
                              color: _currentTab == 2 ? AppTheme.primary : AppTheme.slate500,
                              letterSpacing: 0.5,
                            ),
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
      ),
    );
  }

  Widget _buildActiveTripSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active Trip',
                style: TextStyle(
                  color: AppTheme.slate900,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.green100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'IN PROGRESS',
                  style: TextStyle(
                    color: AppTheme.green700,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.slate100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                _buildMapHeader(),
                _buildTripDetails(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapHeader() {
    return SizedBox(
      height: 192,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/trip_map.jpg',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: AppTheme.slate200),
          ),
          Container(
            color: AppTheme.primary.withValues(alpha: 0.05),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Live Tracking',
                    style: TextStyle(
                      color: AppTheme.slate700,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'VEHICLE DETAILS',
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'KA-01-MG-1234',
                    style: TextStyle(
                      color: AppTheme.slate900,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Toyota Innova • White',
                    style: TextStyle(
                      color: AppTheme.slate500,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 80),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      'OTP',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Text(
                      '1234',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: AppTheme.slate100),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ETA TO PICKUP',
                      style: TextStyle(
                        color: AppTheme.slate500,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.schedule, color: AppTheme.primary, size: 20),
                        SizedBox(width: 6),
                        Text(
                          '12 mins',
                          style: TextStyle(
                            color: AppTheme.slate900,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 32, color: AppTheme.slate200),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DRIVER',
                      style: TextStyle(
                        color: AppTheme.slate500,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.person, color: AppTheme.slate600, size: 20),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Rajesh Kumar',
                            style: TextStyle(
                              color: AppTheme.slate900,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.map, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Track on Map',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppTheme.primary, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.location_on, color: AppTheme.primary, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "I've Reached",
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOtherTripsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Other Trips',
                style: TextStyle(
                  color: AppTheme.slate900,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildUpcomingTripCard(
            title: 'Evening Login',
            timeInfo: 'Today • 6:30 PM',
            icon: Icons.commute,
            status: 'Vehicle Allocated',
            statusColor: AppTheme.blue500,
            statusTextColor: AppTheme.blue600,
            trailingIcon: Icons.chevron_right,
            iconColor: AppTheme.primary,
          ),
          const SizedBox(height: 12),
          _buildUpcomingTripCard(
            title: 'Morning Pickup',
            timeInfo: 'Tomorrow • 8:00 AM',
            icon: Icons.event,
            status: 'Awaiting Allocation',
            statusColor: AppTheme.slate300,
            statusTextColor: AppTheme.slate500,
            trailingIcon: Icons.lock,
            iconColor: AppTheme.slate400,
            opacity: 0.75,
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingTripCard({
    required String title,
    required String timeInfo,
    required IconData icon,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    required IconData trailingIcon,
    required Color iconColor,
    double opacity = 1.0,
  }) {
    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.slate100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.slate100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppTheme.slate900,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    timeInfo,
                    style: const TextStyle(
                      color: AppTheme.slate500,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: statusTextColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(trailingIcon, color: AppTheme.slate400),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingTabSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Upcoming Trips',
            style: TextStyle(
              color: AppTheme.slate900,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildUpcomingTripCard(
            title: 'Evening Login',
            timeInfo: 'Today • 6:30 PM',
            icon: Icons.commute,
            status: 'Vehicle Allocated',
            statusColor: AppTheme.blue500,
            statusTextColor: AppTheme.blue600,
            trailingIcon: Icons.chevron_right,
            iconColor: AppTheme.primary,
          ),
          const SizedBox(height: 12),
          _buildUpcomingTripCard(
            title: 'Morning Pickup',
            timeInfo: 'Tomorrow • 8:00 AM',
            icon: Icons.event,
            status: 'Awaiting Allocation',
            statusColor: AppTheme.slate300,
            statusTextColor: AppTheme.slate500,
            trailingIcon: Icons.lock,
            iconColor: AppTheme.slate400,
            opacity: 0.75,
          ),
          const SizedBox(height: 12),
          _buildUpcomingTripCard(
            title: 'Evening Login',
            timeInfo: 'Tomorrow • 6:30 PM',
            icon: Icons.commute,
            status: 'Awaiting Allocation',
            statusColor: AppTheme.slate300,
            statusTextColor: AppTheme.slate500,
            trailingIcon: Icons.lock,
            iconColor: AppTheme.slate400,
            opacity: 0.75,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTabSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Past Trips',
            style: TextStyle(
              color: AppTheme.slate900,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          _buildUpcomingTripCard(
            title: 'Morning Pickup',
            timeInfo: 'Yesterday • 8:15 AM',
            icon: Icons.check_circle_outline,
            status: 'Completed',
            statusColor: AppTheme.green500,
            statusTextColor: AppTheme.green700,
            trailingIcon: Icons.chevron_right,
            iconColor: AppTheme.green600,
            opacity: 0.8,
          ),
          const SizedBox(height: 12),
          _buildUpcomingTripCard(
            title: 'Evening Login',
            timeInfo: 'Yesterday • 6:40 PM',
            icon: Icons.check_circle_outline,
            status: 'Completed',
            statusColor: AppTheme.green500,
            statusTextColor: AppTheme.green700,
            trailingIcon: Icons.chevron_right,
            iconColor: AppTheme.green600,
            opacity: 0.8,
          ),
          const SizedBox(height: 12),
          _buildUpcomingTripCard(
            title: 'Morning Pickup',
            timeInfo: 'Mon, 23 Mar • 8:00 AM',
            icon: Icons.cancel_outlined,
            status: 'Skipped',
            statusColor: AppTheme.slate400,
            statusTextColor: AppTheme.slate600,
            trailingIcon: Icons.chevron_right,
            iconColor: AppTheme.slate400,
            opacity: 0.6,
          ),
          const SizedBox(height: 12),
          _buildUpcomingTripCard(
            title: 'Evening Login',
            timeInfo: 'Mon, 23 Mar • 6:30 PM',
            icon: Icons.check_circle_outline,
            status: 'Completed',
            statusColor: AppTheme.green500,
            statusTextColor: AppTheme.green700,
            trailingIcon: Icons.chevron_right,
            iconColor: AppTheme.green600,
            opacity: 0.8,
          ),
        ],
      ),
    );
  }
}
