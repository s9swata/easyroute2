import 'package:flutter/material.dart';
import 'theme.dart';
import 'home_screen.dart';

void main() {
  runApp(const EasyRouteApp());
}

class EasyRouteApp extends StatelessWidget {
  const EasyRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyRoute',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
