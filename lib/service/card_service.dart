import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String get userId => "USER_001"; // replace with Firebase Auth later

  /// ➤ Add item to subcollection
  Future<void> addToCart(Map<String, dynamic> data) async {
    await _firestore
        .collection("carts")
        .doc(userId)
        .collection("items")
        .add(data);
  }

  /// ➤ Get cart items in real-time
  Stream<List<Map<String, dynamic>>> getCartStream() {
    return _firestore
        .collection("carts")
        .doc(userId)
        .collection("items")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              return {
                "id": doc.id,
                ...doc.data(),
              };
            }).toList());
  }

  /// ➤ Update qty
  Future<void> updateQty(String docId, int newQty) async {
    await _firestore
        .collection("carts")
        .doc(userId)
        .collection("items")
        .doc(docId)
        .update({
      "qty": newQty,
    });
  }

  /// ➤ Delete item
  Future<void> deleteItem(String docId) async {
    await _firestore
        .collection("carts")
        .doc(userId)
        .collection("items")
        .doc(docId)
        .delete();
  }
}
