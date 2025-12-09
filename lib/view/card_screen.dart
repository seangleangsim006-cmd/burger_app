import 'package:burger_app/controller/card_controller.dart';
import 'package:burger_app/view/choose_address_screen.dart';
import 'package:burger_app/view/thank_you_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  final CartController cart = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("My Cart"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),

      body: Obx(() {
        if (cart.items.isEmpty) {
          return Center(
            child: Text("Your cart is empty!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final item = cart.items[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            item['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 15),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'],
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text("\$${item['price']}"),
                              Text("Size: ${item['size']}"),
                            ],
                          ),
                        ),

                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle,
                                      color: Colors.red),
                                  onPressed: () {
                                    int newQty = item['qty'] - 1;
                                    if (newQty > 0) {
                                      cart.cartService
                                          .updateQty(item['id'], newQty);
                                    } else {
                                      cart.removeItem(item['id']);
                                    }
                                  },
                                ),
                                Text("${item['qty']}"),
                                IconButton(
                                  icon: Icon(Icons.add_circle,
                                      color: Colors.green),
                                  onPressed: () {
                                    int newQty = item['qty'] + 1;
                                    cart.cartService
                                        .updateQty(item['id'], newQty);
                                  },
                                ),
                              ],
                            ),

                            GestureDetector(
                              onTap: () => cart.removeItem(item['id']),
                              child: Text("Remove",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14)),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            /// TOTAL SECTION
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                        "Total: \$${cart.totalPrice.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepOrange,
                      padding: EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                        
                        Get.to(ChooseAddressScreen());
                    },
                    child:
                        Text("Checkout", style: TextStyle(fontSize: 18)),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
