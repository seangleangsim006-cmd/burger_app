import 'package:burger_app/controller/card_controller.dart';
import 'package:burger_app/view/thank_you_screen.dart';
import 'package:flutter/material.dart';

class ChooseAddressScreen extends StatefulWidget {
  @override
  State<ChooseAddressScreen> createState() => _ChooseAddressScreenState();
}

class _ChooseAddressScreenState extends State<ChooseAddressScreen> {
  String selectedAddress = "";
  String selectedPayment = "";

  List<String> addressList = [
    "Home: Street 12, Phnom Penh",
    "Work: Toul Kork Office",
    "School: ICT Building"
  ];
  CartController card = CartController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text("Checkout"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔥 ADDRESS SECTION
            const Text(
              "Choose Delivery Address",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView(
                children: [
                  ...addressList.map((addr) => buildAddressCard(addr)).toList(),

                  const SizedBox(height: 20),

                  // 🔥 PAYMENT METHOD SECTION
                  const Text(
                    "Select Payment Method",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  buildPaymentCard(
                    "ABA Bank",
                    "asset/image/aba.png",   // <-- Put your ABA image
                  ),
                  buildPaymentCard(
                    "ACLEDA Bank",
                    "asset/image/ac.png", // <-- Put your ACLEDA image
                  ),
                  buildPaymentCard(
                    "Canadia",
                    "asset/image/canadia.png",   // <-- Put your WING image
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),

            // 🔥 CONTINUE BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: (selectedAddress.isEmpty || selectedPayment.isEmpty)
                  ? null
                  : () {
                     card.checkout();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>ThankYouScreen()
                        ),
                      );
                    },
             
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Address Card UI
  Widget buildAddressCard(String address) {
    bool isSelected = selectedAddress == address;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAddress = address;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(color: Colors.deepOrange, width: 2)
              : Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: isSelected ? Colors.deepOrange : Colors.grey,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                address,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.deepOrange : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.deepOrange)
          ],
        ),
      ),
    );
  }

  // 🔹 Payment Card UI
  Widget buildPaymentCard(String title, String imagePath) {
    bool isSelected = selectedPayment == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: isSelected
              ? Border.all(color: Colors.deepOrange, width: 2)
              : Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 45,
              height: 45,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.deepOrange : Colors.black87,
              ),
            ),
            Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.deepOrange),
          ],
        ),
      ),
    );
  }
}
