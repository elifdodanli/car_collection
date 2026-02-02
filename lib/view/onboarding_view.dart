import 'package:car_collection/core/constants/app_colors.dart';
import 'package:car_collection/view/home_view.dart';
import 'package:car_collection/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return RegisterView();
                  },
                ),
              );
            },
            child: Text(
              "Skip",
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    isLastPage = index == 2; // 3. sayfa son sayfa
                  });
                },
                children: [
                  buildPage(
                    image: "assets/images/onboarding_one.jpg",
                    title: "Collect your dream cars",
                    subtitle:
                        "From your favorite classics to the latest supercars, build your personal collection.",
                  ),
                  buildPage(
                    image: "assets/images/onboarding_two.jpg",
                    title: "Save Your Favorites",
                    subtitle:
                        "Keep track of the cars you love and never lose them.",
                  ),
                  buildPage(
                    image: "assets/images/onboarding_three.png",
                    title: "Personalize Your Profile",
                    subtitle:
                        "Create your own garage, add photos and showcase your style.",
                  ),
                ],
              ),
            ),
            // dots indicator
            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: AppColors.primaryNavy,
                dotColor: AppColors.softPink,
              ),
            ),
            const SizedBox(height: 20),
            // next / done button
            ElevatedButton(
              onPressed: () {
                if (isLastPage) {
                  print("Onboarding finished");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RegisterView();
                      },
                    ),
                  );
                } else {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isLastPage
                    ? AppColors.softPink
                    : AppColors.primaryNavy, // Changes color on last page!
                foregroundColor: isLastPage
                    ? AppColors.primaryNavy
                    : Colors.white,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: Text(isLastPage ? "Get Started" : "Next"),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(image, height: 250, fit: BoxFit.cover),
        ),
        const SizedBox(height: 40),
        Text(
          title,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          subtitle,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
