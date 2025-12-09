import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchControllerr extends GetxController {
  final searchCtrl = TextEditingController();

  /// Observables
  RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filteredProducts = <Map<String, dynamic>>[].obs;

  RxBool isLoading = false.obs;

  /// Categories
  RxList<String> categories = [
    "All",
    "Burger",
    "Pizza",
    "Drink",
    "Coffee",
    "Meat"
  ].obs;

  RxString selectedCategory = "All".obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  /// 🔥 Load all products from Firestore
  Future<void> fetchProducts() async {
    isLoading.value = true;

    final snapshot =
        await FirebaseFirestore.instance.collection("products").get();

    final List<Map<String, dynamic>> loaded = snapshot.docs.map((doc) {
      final data = doc.data();

      return {
        "id": doc.id,
        "name": data["name"] ?? "",
        "price": data["price"] ?? 0,
        "category": data["category"] ?? "",
        "image": data["image"] ?? "",
      };
    }).toList();

    products.assignAll(loaded);
    filteredProducts.assignAll(loaded);

    isLoading.value = false;
  }

  /// 🔍 SEARCH TEXT
  void searchProducts(String query) {
    final q = query.toLowerCase();

    filteredProducts.assignAll(
      products.where((p) {
        final name = p["name"]?.toString().toLowerCase() ?? "";
        return name.contains(q);
      }).toList(),
    );

    applyCategoryFilter();
  }

  /// 🟠 FILTER BY CATEGORY
  void filterByCategory(String category) {
    selectedCategory.value = category;
    applyCategoryFilter();
  }

  /// Combine search + category
  void applyCategoryFilter() {
    final query = searchCtrl.text.toLowerCase();
    final category = selectedCategory.value;

    filteredProducts.assignAll(
      products.where((p) {
        final bool matchSearch =
            p["name"].toString().toLowerCase().contains(query);

        final bool matchCategory =
            category == "All" || p["category"] == category;

        return matchSearch && matchCategory;
      }).toList(),
    );
  }
}
