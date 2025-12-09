import 'package:burger_app/view/home_screen.dart';
import 'package:flutter/material.dart';

class GetStartScreen extends StatefulWidget {
  const GetStartScreen({super.key});

  @override
  State<GetStartScreen> createState() => _GetStartScreenState();
}

class _GetStartScreenState extends State<GetStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 90,
            bottom: 20,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              Image.asset("asset/image/logo.png"),
              Text(
                "Enjoy the best\n food with\n us...",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Burger App is a fast and easy food-ordering application designed for burger lovers. Users can browse a delicious menu of burgers, sides, and drinks, customize orders, and place delivery.",
                style: TextStyle(height: 1.2),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.deepOrange,
                  ),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
