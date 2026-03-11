import 'package:car_collection/core/constants/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add for car count
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final String joinDate = user?.metadata.creationTime != null
        ? DateFormat('MMMM yyyy').format(user!.metadata.creationTime!)
        : "2026";

    return Scaffold(
      backgroundColor: AppColors.pearlWhite,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              ClipPath(
                clipper: SymmetricalCurveClipper(),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: AppColors.primaryNavy,
                ),
              ),
              Positioned(
                bottom: -40,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.pearlWhite,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.softPink.withOpacity(0.3),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 60),

          // User Info Section
          Text(
            user?.displayName ?? "Collector",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryNavy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user?.email ?? "no-email@garage.com",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
          ),

          const SizedBox(height: 24),

          // Dynamic Stats Row
          _buildStatsRow(user?.uid),

          const SizedBox(height: 30),

          const Spacer(),
          Text(
            "Member since $joinDate",
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // A widget to fetch and display the car count dynamically
  Widget _buildStatsRow(String? userId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('cars')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        final carCount = snapshot.hasData ? snapshot.data!.docs.length : 0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _statItem("Cars", carCount.toString()),
            const SizedBox(width: 40),
            _statItem("Rank", carCount > 10 ? "Expert" : "Newbie"),
          ],
        );
      },
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryNavy,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}

class SymmetricalCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);

    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height - 40);

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldDelegate) => false;
}
