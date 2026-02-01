
import 'package:car_collection/core/constants/app_colors.dart';
import 'package:car_collection/view/onboarding_view.dart';
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
    Future<void>.delayed(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OnboardingView()));
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("If you can dream it, you can do it.", 
            style: TextStyle(
              color: AppColors.deepPink,
              fontWeight: FontWeight.bold, fontSize: 24),),
            Text("- Enzo Ferrari", style: 
            TextStyle(
            color: AppColors.deepPink,
            fontWeight: FontWeight.bold, fontSize: 20),),
        Lottie.asset('assets/lotties/welcome_car_animation.json'),
              
            ],
          ),
    );

    
  }
}