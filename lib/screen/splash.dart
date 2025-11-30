import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/screen/auth/auth_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _navigateToNextScreen() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AuthWrapper()
        )
    );
  }

  @override
  void initState() {
    super.initState();

    Timer(
        Duration(milliseconds: 2500),
        _navigateToNextScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/ornament-top.png'),
            Image.asset('assets/images/logo.png'),
            Image.asset('assets/images/ornament-bottom.png',)
          ],
        )
    );
  }
}