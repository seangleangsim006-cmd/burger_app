class Product {
  final String id;
  final String name;
  final String description;
  final String category;
  final String image;
  final Map<String, double> price;  // ALWAYS double

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
  });

  // Convert any type to double (int/double/string)
  static double _toDouble(dynamic value) {
    if (value is int) return value.toDouble();
    if (value is double) return value;
    return double.tryParse(value.toString()) ?? 0.0;
  }

  factory Product.fromMap(Map<String, dynamic> map, String docId) {
    // convert price map to Map<String, double>
    Map<String, double> fixedPrice = {};

    if (map['price'] != null) {
      map['price'].forEach((key, value) {
        fixedPrice[key] = _toDouble(value);
      });
    }

    return Product(
      id: docId,                         // Firestore document ID
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      image: map['image'] ?? '',
      price: fixedPrice,                 // final double map
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "category": category,
      "image": image,
      "price": price,   // already double
    };
  }
}
