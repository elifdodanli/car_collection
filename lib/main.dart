import 'package:car_collection/core/constants/app_colors.dart';
import 'package:car_collection/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Bridges Flutter with the native platform (iOS/Android)
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes Firebase engine using the options file
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const CarCollectionApp());
}

class CarCollectionApp extends StatelessWidget {
  const CarCollectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.pearlWhite,
        primaryColor: AppColors.primaryNavy,
        // This sets the default style for all ElevatedButtons in the app
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryNavy,
            foregroundColor: AppColors.pearlWhite,
            shape: const StadiumBorder(),
          ),
        ),
      ),
      home: SplashView(),
    );
  }
}
