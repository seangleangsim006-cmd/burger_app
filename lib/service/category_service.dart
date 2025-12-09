import 'package:burger_app/model/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  final _db = FirebaseFirestore.instance;

  Future<List<Category>> getCategories() async {
    try {
      final snapshot = await _db.collection("categories").get();

      return snapshot.docs
          .map((doc) => Category.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print("🔥 Error fetching categories: $e");
      return [];
    }
  }
}
