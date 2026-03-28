import 'package:flutter/material.dart';
import 'theme.dart';
import 'bottom_nav_bar.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({super.key});

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
              top: MediaQuery.of(context).padding.top + 116.0, // Header (56) + Tabs (48) + extra space
              bottom: 120.0 + MediaQuery.of(context).padding.bottom, // Bottom Nav
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTodaySection(),
                _buildTomorrowSection(),
              ],
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
        color: AppTheme.backgroundLight,
        border: Border(
          bottom: BorderSide(color: AppTheme.slate200),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top bar
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16.0,
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.of(context).pop(), // Functional back button disguised as menu, or just return. Let's make it pop.
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Icon(Icons.menu, color: AppTheme.slate900, size: 24),
                    ),
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
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
                ),
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: const Icon(Icons.calendar_today_outlined, color: AppTheme.slate900, size: 24),
                ),
              ],
            ),
          ),
          
          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppTheme.primary, width: 3.0),
                    ),
                  ),
                  child: const Text(
                    'Upcoming',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                Container(
                  padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
                  child: const Text(
                    'Past',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.slate500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TODAY',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.slate900,
              letterSpacing: 1.0, // tracking-wider
            ),
          ),
          const SizedBox(height: 12),
          _buildExpandedTripCard(),
          const SizedBox(height: 16),
          _buildCollapsedTripCard(
            tripId: 'TRIP ID: ER-9945 • Regular',
            title: 'Login — 08:30 AM',
            icon: Icons.directions_car_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildTomorrowSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TOMORROW',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.slate900,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          _buildCollapsedTripCard(
            tripId: 'TRIP ID: ER-1002 • Ad-hoc',
            title: 'Logout — 05:30 PM',
            icon: Icons.logout_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedTripCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // rounded-xl
        border: Border.all(color: AppTheme.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4, // shadow-sm
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Map Header
          Container(
            width: double.infinity,
            height: 150, // aspect-[21/9] roughly
            decoration: const BoxDecoration(
              color: AppTheme.slate200,
              image: DecorationImage(
                image: AssetImage('assets/images/trip_map.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7), // green-100
                      borderRadius: BorderRadius.circular(4), // rounded
                    ),
                    child: const Text(
                      'ACCEPTED',
                      style: TextStyle(
                        fontSize: 12, // text-xs
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF15803D), // green-700
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0), // p-4
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TRIP ID: ER-9921',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.slate500,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Logout — 06:00 PM',
                          style: TextStyle(
                            fontSize: 20, // text-xl
                            fontWeight: FontWeight.bold,
                            color: AppTheme.slate900,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.expand_less, color: AppTheme.slate400),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Details Grid
                Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFF1F5F9)), // border-slate-100
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildGridItem('Booking Type', 'Regular'),
                            const SizedBox(height: 16),
                            _buildGridItem('Pickup Seq', '2nd Drop-off'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildGridItem('Office', 'Main Campus HQ'),
                            const SizedBox(height: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'ETA',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.slate500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'N/A',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.slate900.withValues(alpha: 0.6), // opacity-60
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 44, // h-11
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(8), // rounded-lg
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: const Text(
                          'View Route',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2), // red-50
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFFECACA)), // red-200
                        ),
                        child: const Text(
                          'Cancel Trip',
                          style: TextStyle(
                            color: Color(0xFFDC2626), // red-600
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppTheme.slate500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14, // text-sm
            fontWeight: FontWeight.w600, // font-semibold
            color: AppTheme.slate900,
          ),
        ),
      ],
    );
  }

  Widget _buildCollapsedTripCard({required String tripId, required String title, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 48, // size-12
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.1), // bg-primary/10
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: AppTheme.primary, size: 24),
                ),
                const SizedBox(width: 16), // gap-4
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16, // text-base
                                fontWeight: FontWeight.bold,
                                color: AppTheme.slate900,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8), // gap-2
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), // px-1.5 py-0.5
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7), // green-100
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'ACCEPTED',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF15803D), // green-700
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tripId,
                        style: const TextStyle(
                          fontSize: 12, // text-xs
                          color: AppTheme.slate500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.expand_more, color: AppTheme.slate400),
        ],
      ),
    );
  }
}
