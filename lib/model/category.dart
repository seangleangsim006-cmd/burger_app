class Category {
  String name;
  String image;
  Category({required this.name, required this.image});


  
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
    );
  }
}

