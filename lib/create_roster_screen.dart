import 'package:flutter/material.dart';
import 'theme.dart';

class CreateRosterScreen extends StatelessWidget {
  const CreateRosterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  bottom: 180,
                ), // Increased padding for the bottom sticky button
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Trip Direction
                          _buildSectionTitle('Trip Direction'),
                      const SizedBox(height: 12),
                      _buildTripDirectionSelector(),
                      const SizedBox(height: 24),
                      
                      // Office Location
                      _buildOfficeLocation(),
                      const SizedBox(height: 24),
                      
                      // Weekly Offs
                      _buildSectionTitle('Weekly Offs'),
                      const SizedBox(height: 12),
                      _buildWeeklyOffs(),
                      const SizedBox(height: 24),
                      
                      // Dates
                      _buildDateSelection(),
                      const SizedBox(height: 24),
                      
                      // Times
                      _buildTimeSelection(),
                      const SizedBox(height: 24),
                      
                      // Locations
                      _buildLocationSelection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
          ],
        ),
      ),
      bottomSheet: _buildBottomAction(context),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: const BoxDecoration(
        color: AppTheme.backgroundLight,
        border: Border(
          bottom: BorderSide(color: AppTheme.slate200, width: 1.0),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Row(
            children: [
              Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              hoverColor: AppTheme.slate200,
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.arrow_back, color: AppTheme.slate900, size: 24),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Create Roster',
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
            child: Icon(Icons.more_vert, color: AppTheme.slate900, size: 24),
          ),
        ],
      ),
    ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppTheme.slate900,
        height: 1.25,
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppTheme.slate900,
      ),
    );
  }

  Widget _buildTripDirectionSelector() {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.slate200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: _buildDirectionTab('Login', false)),
          Expanded(child: _buildDirectionTab('Logout', false)),
          Expanded(child: _buildDirectionTab('Both', true)),
        ],
      ),
    );
  }

  Widget _buildDirectionTab(String label, bool isSelected) {
    return Container(
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            )
          : null,
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isSelected ? AppTheme.primary : AppTheme.slate500, // Tailwind: slate-600 logic approx
        ),
      ),
    );
  }

  Widget _buildOfficeLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Office Location'),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.slate100,
            border: Border.all(color: AppTheme.slate200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Innovation Tech Park, Tower B, Sector 62',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.slate500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(Icons.lock_outline, color: AppTheme.slate400, size: 20),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Office location is fixed based on your profile.',
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: AppTheme.slate500,
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyOffs() {
    final days = [
      {'label': 'M', 'selected': false},
      {'label': 'T', 'selected': false},
      {'label': 'W', 'selected': false},
      {'label': 'T', 'selected': false},
      {'label': 'F', 'selected': false},
      {'label': 'S', 'selected': true},
      {'label': 'S', 'selected': true},
    ];

    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.start,
      children: days.map((day) {
        final isSelected = day['selected'] as bool;
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary : AppTheme.backgroundLight,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? AppTheme.primary : AppTheme.slate200,
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            day['label'] as String,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : AppTheme.slate500, // Tailwinds: text-slate-600
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDateSelection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFieldLabel('Start Date'),
              const SizedBox(height: 8),
              _buildInputPlaceholder('yyyy-mm-dd'),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFieldLabel('End Date'),
              const SizedBox(height: 8),
              _buildInputPlaceholder('yyyy-mm-dd'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputPlaceholder(String hint) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.slate200),
      ),
      child: Text(
        hint,
        style: const TextStyle(fontSize: 14, color: AppTheme.slate400),
      ),
    );
  }

  Widget _buildTimeSelection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFieldLabel('Login Time'),
                const SizedBox(height: 8),
                _buildTimePicker('09:00', Icons.schedule),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFieldLabel('Logout Time'),
                const SizedBox(height: 8),
                _buildTimePicker('18:00', Icons.logout),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker(String time, IconData icon) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.slate200),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primary, size: 20),
          const SizedBox(width: 8),
          Text(
            time,
            style: const TextStyle(fontSize: 14, color: AppTheme.slate900),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSelection() {
    return Column(
      children: [
        _buildDropdown('Pickup Location'),
        const SizedBox(height: 16),
        _buildDropdown('Drop Location'),
      ],
    );
  }

  Widget _buildDropdown(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel(label),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.slate200),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Home - Residency Road, Apt 402',
                style: TextStyle(fontSize: 14, color: AppTheme.slate900),
                overflow: TextOverflow.ellipsis,
              ),
              Icon(Icons.expand_more, color: AppTheme.slate400, size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 16 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppTheme.backgroundLight,
        border: Border(top: BorderSide(color: AppTheme.slate200)),
      ),
      child: Container(
        height: 56, // h-14
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.2),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.save_outlined, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Save Roster',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
