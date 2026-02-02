import 'package:car_collection/core/constants/app_colors.dart';
import 'package:car_collection/core/services/cache_manager.dart';
import 'package:car_collection/view/home_view.dart';
import 'package:car_collection/view/onboarding_view.dart';
import 'package:car_collection/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    // Only call the status check logic
    _checkAppStatus();
  }

  Future<void> _checkAppStatus() async {
    // Show splash for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Get statuses from CacheManager
    final bool loggedIn = await CacheManager.isLoggedIn();
    final bool firstTime = await CacheManager.isFirstTime();

    if (loggedIn) {
      // Direct access to Home if already registered
      _navigateTo(const HomeView());
    } else if (!firstTime) {
      // Show login/register if onboarding is already completed
      _navigateTo(const RegisterView());
    } else {
      // Show onboarding for new users
      _navigateTo(const OnboardingView());
    }
  }

  void _navigateTo(Widget destination) {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pearlWhite,
      body: Center(
        // Center for better layout
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "If you can dream it, you can do it.",
              style: TextStyle(
                color: AppColors.deepPink,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "- Enzo Ferrari",
              style: TextStyle(
                color: AppColors.deepPink,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Lottie.asset('assets/lotties/welcome_car_animation.json'),
          ],
        ),
      ),
    );
  }
}
