class CartItem {
  String id;          // Firestore document ID
  String productId;
  String name;
  String image;
  double price;
  int qty;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
  });

  Map<String, dynamic> toMap() {
    return {
      "productId": productId,
      "name": name,
      "image": image,
      "price": price,
      "qty": qty,
    };
  }

  factory CartItem.fromMap(String docId, Map<String, dynamic> map) {
    return CartItem(
      id: docId,
      productId: map["productId"] ?? "",
      name: map["name"] ?? "",
      image: map["image"] ?? "",
      price: (map["price"] as num).toDouble(),
      qty: (map["qty"] as num).toInt(),       // 👈 ensure int
    );
  }
}
