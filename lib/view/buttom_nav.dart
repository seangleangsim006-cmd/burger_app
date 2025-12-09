import 'package:burger_app/controller/buttom_nav_contoller.dart';
import 'package:burger_app/view/home_screen.dart';
import 'package:burger_app/view/profile_screen.dart';
import 'package:burger_app/view/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BottomNavScreen extends StatelessWidget {
  BottomNavScreen({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    HomeScreen(),
    SearchScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[controller.currentIndex.value],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "search"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile"
              ),
            ],
          ),
        ));
  }
}
