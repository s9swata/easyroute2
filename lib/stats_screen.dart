import 'package:flutter/material.dart';
import 'theme.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: AppTheme.slate200)),
          ),
          child: SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back, color: AppTheme.slate900, size: 28),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'My Trip Status',
                          style: TextStyle(
                            color: AppTheme.slate900,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'EXPORT',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCalendarSection(),
                _buildChartSection(),
                _buildAdhocBookingsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.chevron_left, color: AppTheme.slate900),
              const Text(
                'October 2023',
                style: TextStyle(
                  color: AppTheme.slate900,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.chevron_right, color: AppTheme.slate900),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      color: AppTheme.slate500,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildDayCircle('28', isFaded: true),
              _buildDayCircle('29', isFaded: true),
              _buildDayCircle('30', isFaded: true),
              _buildDayCircle('1'),
              _buildDayCircle('2'),
              _buildDayCircle('3'),
              _buildDayCircle('4'),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              _buildDayCircle('5', isStartRange: true),
              _buildDayCircle('6', inRange: true),
              _buildDayCircle('7', inRange: true),
              _buildDayCircle('8', inRange: true),
              _buildDayCircle('9', inRange: true),
              _buildDayCircle('10', inRange: true),
              _buildDayCircle('11', isEndRange: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayCircle(String day, {
    bool isFaded = false,
    bool inRange = false,
    bool isStartRange = false,
    bool isEndRange = false,
  }) {
    Color bgColor = Colors.transparent;
    Color textColor = isFaded ? AppTheme.slate400.withValues(alpha: 0.5) : AppTheme.slate900;
    BorderRadius? borderRadius;

    if (inRange) {
      bgColor = AppTheme.primary.withValues(alpha: 0.2);
    } else if (isStartRange) {
      bgColor = AppTheme.primary;
      textColor = Colors.white;
      borderRadius = BorderRadius.circular(20);
    } else if (isEndRange) {
      bgColor = AppTheme.primary;
      textColor = Colors.white;
      borderRadius = BorderRadius.circular(20);
    }

    return Expanded(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: borderRadius,
        ),
        alignment: Alignment.center,
        child: Text(
          day,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: isFaded ? FontWeight.normal : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildChartSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.slate200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Daily Trip Stats',
            style: TextStyle(
              color: AppTheme.slate500,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: const [
              Text(
                '128',
                style: TextStyle(
                  color: AppTheme.slate900,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Total',
                style: TextStyle(
                  color: AppTheme.slate500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          const Text(
            'Last 7 Days (Oct 5 - Oct 11)',
            style: TextStyle(
              color: AppTheme.slate400,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildLegendItem(AppTheme.primary, 'Check-ins'),
              const SizedBox(width: 16),
              _buildLegendItem(AppTheme.slate300, 'Scheduled'),
              const SizedBox(width: 16),
              _buildLegendItem(AppTheme.red400, 'No-shows'),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 192,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBar('MON', 10, 60, 20),
                _buildBar('TUE', 5, 40, 30),
                _buildBar('WED', 15, 55, 20),
                _buildBar('THU', 8, 75, 10),
                _buildBar('FRI', 5, 65, 25),
                _buildBar('SAT', 2, 30, 15),
                _buildBar('SUN', 1, 20, 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: AppTheme.slate700,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBar(String label, int redPct, int bluePct, int grayPct) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double maxHeight = constraints.maxHeight;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 24,
                      height: maxHeight * (redPct / 100),
                      decoration: BoxDecoration(
                        color: AppTheme.red400.withValues(alpha: 0.2),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      width: 24,
                      height: maxHeight * (bluePct / 100),
                      decoration: const BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Container(
                      width: 24,
                      height: maxHeight * (grayPct / 100),
                      decoration: const BoxDecoration(
                        color: AppTheme.slate300,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.slate500,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdhocBookingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Adhoc Bookings',
                style: TextStyle(
                  color: AppTheme.slate900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.slate200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'TODAY',
                  style: TextStyle(
                    color: AppTheme.slate500,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildBookingCard(
            'Sarah Jenkins',
            'Downtown to North Station',
            '09:15 AM',
            'CONFIRMED',
            AppTheme.green100,
            AppTheme.green700,
            AppTheme.primary.withValues(alpha: 0.1),
            AppTheme.primary,
          ),
          const SizedBox(height: 12),
          _buildBookingCard(
            'Michael Chen',
            'Airport Terminal 2 to Hilton',
            '10:45 AM',
            'PENDING',
            AppTheme.yellow100,
            AppTheme.yellow700,
            AppTheme.slate100,
            AppTheme.slate500,
          ),
          const SizedBox(height: 12),
          _buildBookingCard(
            'Lisa Rodriguez',
            'Tech Park to West Mall',
            '11:30 AM',
            'DISPATCHED',
            AppTheme.primary.withValues(alpha: 0.1),
            AppTheme.primary,
            AppTheme.slate100,
            AppTheme.slate500,
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(
      String name, String route, String time, String status, Color statusBg, Color statusText, Color avatarBg, Color avatarIcon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.slate200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: avatarBg,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: avatarIcon, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppTheme.slate900,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  route,
                  style: const TextStyle(
                    color: AppTheme.slate500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: AppTheme.slate900,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusText,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
