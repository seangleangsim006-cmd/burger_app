import 'package:burger_app/service/card_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartService cartService = CartService();
  

  var items = [].obs;

  @override
  void onInit() {
    super.onInit();

    /// Listen real-time changes
    cartService.getCartStream().listen((data) {
      items.value = data;
    });
  }

  /// Add To Cart
  void addToCart({
    required String productId,
    required String name,
    required String image,
    required double price,
    required String size,
    required String category,
    required int qty,
  }) {
    final data = {
      "productId": productId,
      "name": name,
      "image": image,
      "price": price,
      "size": size,
      "category": category,
      "qty": qty,
    };

    cartService.addToCart(data);
  }

  /// Remove item
  void removeItem(String id) {
    cartService.deleteItem(id);
  }

  /// Total price
  double get totalPrice {
    double total = 0;
    for (var item in items) {
      total += item["price"] * item["qty"];
    }
    return total;
  }

  /// Total quantity
  int get totalQty {
    int total = 0;
    for (var item in items) {
      total += (item["qty"] as num).toInt();

    }
    return total;
  }
  Future<void> checkout() async {
  if (items.isEmpty) {
    Get.snackbar("Cart Empty", "Please add items before checkout");
    return;
  }

  final userId = "USER001"; // TODO: replace with FirebaseAuth UID

  final orderData = {
    "items": items,
    "totalPrice": totalPrice,
    "totalQty": totalQty,
    "date": DateTime.now(),
  };

  await FirebaseFirestore.instance
      .collection("orders")
      .doc(userId)
      .collection("user_orders")
      .add(orderData);

  // Clear cart
  await FirebaseFirestore.instance
      .collection("carts")
      .doc(userId)
      .collection("items")
      .get()
      .then((snapshot) {
    for (var doc in snapshot.docs) {
      doc.reference.delete();
    }
  });

  items.clear();

  Get.snackbar("Success", "Order placed successfully!",
      backgroundColor: Colors.green, colorText: Colors.white);
}

}
