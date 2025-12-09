import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          const SizedBox(height: 60),

          // Profile Avatar
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.deepOrange.withOpacity(0.3),
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/300", // fake profile image
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Name
          const Text(
            "Bong SML",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 5),

          // Email
          Text(
            "bongSml@example.com",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),

          const SizedBox(height: 25),

          // Options List
          Expanded(
            child: ListView(
              children: [
                buildMenuItem(Icons.person, "Edit Profile"),
                buildMenuItem(Icons.location_on, "My Address"),
                buildMenuItem(Icons.shopping_bag, "My Orders"),
                buildMenuItem(Icons.favorite, "Favorites"),
                buildMenuItem(Icons.notifications, "Notifications"),
                buildMenuItem(Icons.settings, "Settings"),
              ],
            ),
          ),

          // Logout Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔥 Reusable menu item widget
  Widget buildMenuItem(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepOrange, size: 28),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}
