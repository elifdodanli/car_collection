import 'package:car_collection/core/constants/app_colors.dart';
import 'package:car_collection/view/widgets/car_card.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pearlWhite,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.softPink,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("My Car Collection"),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
              childAspectRatio: 0.85, // Adjust this for box height
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
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.pearlWhite,
        indicatorColor: AppColors.softPink.withOpacity(0.2),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home, color: AppColors.primaryNavy),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(Icons.favorite, color: AppColors.primaryNavy),
            label: "Favorites",
          ),

          NavigationDestination(
            icon: Icon(Icons.person, color: AppColors.primaryNavy),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
