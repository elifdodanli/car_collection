import 'package:car_collection/core/constants/app_colors.dart';
import 'package:car_collection/core/services/cache_manager.dart';
import 'package:car_collection/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pearlWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Garage Entrance Header
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryNavy,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                    ),
                  ),
                ),
                const Column(
                  children: [
                    Icon(Icons.garage, size: 80, color: AppColors.softPink),
                    SizedBox(height: 10),
                    Text(
                      "WELCOME BACK",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () async {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        await CacheManager.setLoggedIn();

                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeView(),
                            ),
                            (route) => false,
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        print("Login Error: ${e.message}");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("OPEN THE GARAGE"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }
}
