import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/screen/item_list.dart';
import 'package:my_first_flutter_app/services/auth_services.dart'; // Check your import path
// import 'package:my_first_flutter_app/screen/beranda.dart'; // Check your import path

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers to capture user input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  // Logic to Handle Login
  void _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan Password tidak boleh kosong")),
      );
      return;
    }

    // 1. Try to Login
    final user = await _authService.signIn(email, password);

    if (user != null && mounted) {
      // Login Success -> Go to Beranda
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ItemListScreen()),
      );
    } else {
      // 2. Login Failed? Try to Register automatically (for Homework speed)
      final newUser = await _authService.register(email, password);

      if (newUser != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ItemListScreen()),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login/Register Gagal. Periksa Email/Password.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ResizeToAvoidBottomInset ensures keyboard doesn't break layout
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xffffffff),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Ornament
            Image.asset('assets/images/ornament-top-2.png'),

            Column(
              children: [
                // Logo
                Image.asset('assets/images/logo-2.png'),
                const SizedBox(height: 16),
                const Text(
                  'Masuk atau Daftar',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),

                // === EMAIL INPUT ===
                Container(
                  width: 372,
                  height: 57,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none, // Remove default underline
                      contentPadding: EdgeInsets.only(left: 17, top: 10, bottom: 10), // Adjusted padding
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // === PASSWORD INPUT (NEW) ===
                Container(
                  width: 372,
                  height: 57,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true, // Hide password text
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 17, top: 10, bottom: 10),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // === LOGIN BUTTON ===
                SizedBox(
                  width: 370,
                  height: 57,
                  child: ElevatedButton(
                    onPressed: _handleLogin, // Calls our logic
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff009421),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      "Selanjutnya",
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 9),

                // OR Divider
                SizedBox(
                  width: 372,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 167, height: 2, color: Colors.black),
                      const SizedBox(width: 3),
                      const Text('OR'),
                      const SizedBox(width: 3),
                      Container(width: 167, height: 2, color: Colors.black),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Google Button (Visual Only for now)
                Container(
                  width: 372,
                  height: 57,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ElevatedButton(
                    onPressed: () {}, // Empty logic
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffffffff),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/google-icon.png'),
                        const SizedBox(width: 4),
                        const Text(
                          'Lanjutkan dengan Google',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16,),

                // Facebook Button (Visual Only for now)
                Container(
                  width: 372,
                  height: 57,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ElevatedButton(
                    onPressed: () {}, // Empty logic
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffffffff),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/facebook-icon.png'),
                        const SizedBox(width: 4),
                        const Text(
                          'Lanjutkan dengan Facebook',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Bottom Ornament
            Image.asset('assets/images/ornament-bottom-2.png'),
          ],
        ),
      ),
    );
  }
}