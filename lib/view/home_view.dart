import 'package:car_collection/core/constants/app_colors.dart';
import 'package:car_collection/core/utils/snackbar_helper.dart';
import 'package:car_collection/view/login_view.dart';
import 'package:car_collection/view/widgets/car_card.dart';
import 'package:car_collection/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_collection/model/car_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Track the current active tab index
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        // Change AppBar color and title based on the active tab
        backgroundColor: _currentIndex == 2
            ? AppColors.primaryNavy
            : AppColors.pearlWhite,
        elevation: 0,
        title: Text(
          _currentIndex == 0
              ? "My Car Collection"
              : _currentIndex == 1
              ? "Favorites"
              : "Profile",
          style: TextStyle(
            color: _currentIndex == 2 ? Colors.white : AppColors.primaryNavy,
          ),
        ),
        // Show logout button only on the Profile tab
        actions: _currentIndex == 2
            ? [
                IconButton(
                  onPressed: () => _handleLogout(context),
                  icon: const Icon(Icons.logout, color: Colors.white),
                ),
              ]
            : null,
      ),
      // Only show FloatingActionButton on the Home tab (index 0)
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                // Future: Add Image Picker Logic
              },
              backgroundColor: AppColors.softPink,
              child: const Icon(Icons.add),
            )
          : null,

      // Switch between different views based on the selected index
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeBody(), // Index 0: Car List
          const Center(
            child: Text("Favorites Coming Soon! 💖"),
          ), // Index 1: Favorites
          const ProfileView(), // Index 2: Profile
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.pearlWhite,
        indicatorColor: AppColors.softPink.withOpacity(0.2),
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  // Extracted Home Body to keep the code organized
  Widget _buildHomeBody() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('cars')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return const Center(
            child: Text("Your garage is empty. Start adding cars! 🏎️"),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final car = CarModel.fromFirestore(
              docs[index].data() as Map<String, dynamic>,
              docs[index].id,
            );
            return CarCard(car: car);
          },
        );
      },
    );
  }
}

void _handleLogout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
        (route) => false,
      );
    }
  } catch (e) {
    SnackBarHelper.show(context, "Logout failed: $e");
  }
}
