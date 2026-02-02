import 'package:car_collection/core/services/cache_manager.dart';
import 'package:car_collection/view/home_view.dart';
import 'package:car_collection/view/login_view.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 400),
            painter: CurvePainter(),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "Create Your Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Driver's License Card
                  Container(
                    height: 200,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.pearlWhite,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.softPink,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: AppColors.primaryNavy,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "DRIVER'S LICENSE",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ValueListenableBuilder(
                                valueListenable: _nameController,
                                builder: (context, value, child) {
                                  return Text(
                                    value.text.isEmpty
                                        ? "YOUR NAME"
                                        : value.text.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryNavy,
                                    ),
                                  );
                                },
                              ),
                              const Text(
                                "Member since 2026",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Text Fields
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Full Name",
                      prefixIcon: Icon(Icons.badge),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController, // Added this!
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Create Password",
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: 40),

                  ElevatedButton(
                    onPressed: () async {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      try {
                        final userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );

                        // Başarılıysa yerel cache'i güncelle
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
                        print("Firebase Auth Error: ${e.message}");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("START YOUR ENGINE"),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Navigate to LoginView
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(
                        color: AppColors.primaryNavy,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(
                        icon: Icons.g_mobiledata,
                        color: Colors.red,
                      ), // Google Placeholder
                      const SizedBox(width: 20),
                      SocialButton(
                        icon: Icons.apple,
                        color: Colors.black,
                      ), // Apple Placeholder
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;
  final Color color;

  const SocialButton({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );
  }
}

// Quadratic Bézier Curve
class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColors.primaryNavy
      ..style = PaintingStyle.fill;

    var path = Path();
    path.lineTo(0, size.height * 0.7);

    // Control point pulled higher for a sleek curve
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 0.9,
      size.width,
      size.height * 0.7,
    );

    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
