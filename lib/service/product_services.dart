import 'package:burger_app/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  final _db = FirebaseFirestore.instance;

Future<List<Product>> getProducts() async {
  final snapshot = await _db.collection("products").get();

  return snapshot.docs
      .map((doc) => Product.fromMap(doc.data(), doc.id))
      .toList();
}

}
