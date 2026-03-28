import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'home_screen.dart';
import 'bottom_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _emergencyContactController;
  late TextEditingController _landmarkController;
  late TextEditingController _tpinController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _emergencyContactController = TextEditingController(text: '+1 (555) 999-8877');
    _landmarkController = TextEditingController(text: '');
    _tpinController = TextEditingController(text: '1234');
    _addressController = TextEditingController(text: '123 Maple Street, Apt 4B, Silicon Valley, CA 94025');
  }

  @override
  void dispose() {
    _emergencyContactController.dispose();
    _landmarkController.dispose();
    _tpinController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _onSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile changes saved successfully!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      extendBody: true,
      bottomNavigationBar: const SharedBottomNavBar(currentIndex: 3),
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 56.0 + MediaQuery.of(context).padding.top + 16.0, // Account for header
              bottom: 120.0 + MediaQuery.of(context).padding.bottom, // Account for bottom nav and button
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(),
                _buildFormFields(),
                _buildMapSection(),
                _buildSaveButton(),
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
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
        child: Container(
          decoration: const BoxDecoration(
            color: AppTheme.backgroundLight,
            border: Border(
              bottom: BorderSide(color: AppTheme.slate200),
            ),
          ),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 16.0,
            left: 16.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: const Icon(Icons.arrow_back, color: AppTheme.slate900, size: 24),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.slate900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: _onSave,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0), // p-6
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 96, // w-24
                height: 96, // h-24
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 4,
                    )
                  ],
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6), // p-1.5
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.photo_camera, color: Colors.white, size: 14), // text-sm
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Johnathan Doe',
            style: TextStyle(
              fontSize: 20, // text-xl
              fontWeight: FontWeight.bold,
              color: AppTheme.slate900,
              letterSpacing: -0.5, // tracking-tight
            ),
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, color: AppTheme.primary, size: 16),
              SizedBox(width: 4),
              Text(
                'Verified Account',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.slate500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0), // px-4
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ReadOnlyPhoneField(),
          const SizedBox(height: 24), // gap-6
          _EditableField(
              label: 'Emergency Contact',
              controller: _emergencyContactController,
              icon: Icons.edit),
          const SizedBox(height: 24),
          _TPinField(controller: _tpinController),
          const SizedBox(height: 24),
          _EditableField(
              label: 'Locality / Landmark',
              controller: _landmarkController,
              hint: 'e.g. Near Central Park Tower'),
          const SizedBox(height: 24),
          _AddressField(controller: _addressController),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Pinned Location',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.slate700,
                ),
              ),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Updating location using GPS...'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.my_location, color: AppTheme.primary, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      'Use GPS Location',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                        decoration: TextDecoration.underline,
                        decorationColor: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 200, // aspect-video approx
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.slate200),
              image: const DecorationImage(
                image: AssetImage('assets/images/map_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20), // rounded-full
                          border: Border.all(color: AppTheme.slate100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: const Text(
                          'Home',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.slate900,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.location_on,
                        color: AppTheme.primary,
                        size: 48, // text-5xl approx
                        shadows: [
                          Shadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16), // mt-8
      child: Container(
        height: 64, // py-4, text-lg
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(12), // rounded-xl
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.2),
              offset: const Offset(0, 8), // shadow-lg approx
              blurRadius: 15,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: _onSave,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.save_outlined, color: Colors.white, size: 24),
                SizedBox(width: 8),
                Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
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

class _ReadOnlyPhoneField extends StatelessWidget {
  const _ReadOnlyPhoneField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            'Mobile Number',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.slate700), // font-semibold
          ),
        ),
        Container(
          height: 56, // h-14
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppTheme.slate100, // bg-slate-100
            borderRadius: BorderRadius.circular(12), // rounded-xl
            border: Border.all(color: AppTheme.slate200),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '+1 (555) 012-3456',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme.slate500),
              ),
              Icon(Icons.lock_outline, color: AppTheme.slate400, size: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class _EditableField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? hint;
  final IconData? icon;

  const _EditableField({required this.label, required this.controller, this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.slate700),
          ),
        ),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.slate200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: const TextStyle(color: AppTheme.slate400),
                  ),
                  style: const TextStyle(fontSize: 16, color: AppTheme.slate900),
                ),
              ),
              if (icon != null) Icon(icon, color: AppTheme.slate400, size: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class _TPinField extends StatefulWidget {
  final TextEditingController controller;
  const _TPinField({required this.controller});

  @override
  State<_TPinField> createState() => _TPinFieldState();
}

class _TPinFieldState extends State<_TPinField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            'T-PIN (Transaction PIN)',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.slate700),
          ),
        ),
        Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.slate200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: _obscureText,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 16, color: AppTheme.slate900),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => setState(() => _obscureText = !_obscureText),
                    icon: Icon(
                      _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: AppTheme.slate400,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.autorenew, color: AppTheme.slate400, size: 20),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Text(
            'Used for route security and fast checkout.',
            style: TextStyle(fontSize: 12, color: AppTheme.slate500),
          ),
        ),
      ],
    );
  }
}

class _AddressField extends StatelessWidget {
  final TextEditingController controller;
  const _AddressField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            'Home Address',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.slate700),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.slate200),
          ),
          child: TextField(
            controller: controller,
            maxLines: 3,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 16, color: AppTheme.slate900),
          ),
        ),
      ],
    );
  }
}
