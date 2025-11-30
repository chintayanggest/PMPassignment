import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_first_flutter_app/screen/item_list.dart'; // <--- Points directly to Homework Page
import 'package:my_first_flutter_app/screen/auth/login.dart';
import 'package:my_first_flutter_app/services/auth_services.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().user, // or .authStateChanges
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) {
          // IF LOGGED IN -> GO TO ITEM LIST (Skip Navbar)
          return const ItemListScreen();
        }
        // IF NOT LOGGED IN -> GO TO LOGIN
        return const LoginScreen();
      },
    );
  }
}