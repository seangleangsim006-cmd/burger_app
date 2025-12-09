import 'package:burger_app/controller/card_controller.dart';
import 'package:burger_app/view/buttom_nav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
    // <-- ADD THIS
   
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); Get.put(CartController()); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: BottomNavScreen(),
    );
  }
}
// -----------------------------------------------------------
// PRODUCT MODEL
// -----------------------------------------------------------
// class Product {
//   final String id;
//   final String name;
//   final String description;
//   final String category;
//   final String image;
//   final Map<String, double> price;

//   Product({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.category,
//     required this.image,
//     required this.price,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       "id": id,
//       "name": name,
//       "description": description,
//       "category": category,
//       "image": image,
//       "price": price,
//     };
//   }
// }

// // -----------------------------------------------------------
// // FAKE PRODUCT LIST (30 ITEMS)
// // -----------------------------------------------------------
// List<Product> fakeProductsList = [
//   Product(
//     id: "p1",
//     name: "Classic Beef Burger",
//     description: "Juicy beef patty with cheese, lettuce, tomato, and signature sauce.",
//     category: "burger",
//     image: "https://picsum.photos/200?random=1",
//     price: {"small": 3.50, "medium": 4.20, "large": 5.00},
//   ),
//   Product(
//     id: "p2",
//     name: "Cheese Lover Burger",
//     description: "Double cheese and premium beef patty.",
//     category: "burger",
//     image: "https://picsum.photos/200?random=2",
//     price: {"small": 4.00, "medium": 4.80, "large": 5.50},
//   ),
//   Product(
//     id: "p3",
//     name: "Chicken Crispy Burger",
//     description: "Crispy fried chicken with mayo.",
//     category: "burger",
//     image: "https://picsum.photos/200?random=3",
//     price: {"small": 3.20, "medium": 4.00, "large": 4.80},
//   ),
//   Product(
//     id: "p4",
//     name: "Double Beef Burger",
//     description: "Two beef patties with cheese.",
//     category: "burger",
//     image: "https://picsum.photos/200?random=4",
//     price: {"small": 4.50, "medium": 5.20, "large": 6.20},
//   ),
//   Product(
//     id: "p5",
//     name: "Spicy Burger",
//     description: "Spicy beef burger with jalapeños.",
//     category: "burger",
//     image: "https://picsum.photos/200?random=5",
//     price: {"small": 3.80, "medium": 4.50, "large": 5.20},
//   ),

//   // MEAT -----------------------------------------------------
//   Product(
//     id: "p6",
//     name: "Grilled Beef Steak",
//     description: "Tender steak grilled with herb butter.",
//     category: "meat",
//     image: "https://picsum.photos/200?random=6",
//     price: {"small": 8.00, "medium": 10.00, "large": 12.00},
//   ),
//   Product(
//     id: "p7",
//     name: "BBQ Pork Ribs",
//     description: "Slow-cooked ribs with BBQ sauce.",
//     category: "meat",
//     image: "https://picsum.photos/200?random=7",
//     price: {"small": 7.00, "medium": 9.00, "large": 11.00},
//   ),
//   Product(
//     id: "p8",
//     name: "Fried Chicken",
//     description: "Crispy golden fried chicken.",
//     category: "meat",
//     image: "https://picsum.photos/200?random=8",
//     price: {"small": 4.50, "medium": 6.00, "large": 7.50},
//   ),
//   Product(
//     id: "p9",
//     name: "Roast Chicken",
//     description: "Oven-roasted with garlic seasoning.",
//     category: "meat",
//     image: "https://picsum.photos/200?random=9",
//     price: {"small": 5.00, "medium": 6.50, "large": 8.00},
//   ),
//   Product(
//     id: "p10",
//     name: "Beef BBQ Plate",
//     description: "Smoky grilled beef strips.",
//     category: "meat",
//     image: "https://picsum.photos/200?random=10",
//     price: {"small": 6.50, "medium": 8.00, "large": 9.50},
//   ),

//   // PIZZA -----------------------------------------------------
//   Product(
//     id: "p11",
//     name: "Pepperoni Pizza",
//     description: "Classic pepperoni and cheese.",
//     category: "pizza",
//     image: "https://picsum.photos/200?random=11",
//     price: {"small": 4.50, "medium": 6.00, "large": 7.50},
//   ),
//   Product(
//     id: "p12",
//     name: "Cheese Pizza",
//     description: "Delicious cheese-only pizza.",
//     category: "pizza",
//     image: "https://picsum.photos/200?random=12",
//     price: {"small": 4.00, "medium": 5.50, "large": 7.00},
//   ),
//   Product(
//     id: "p13",
//     name: "Hawaiian Pizza",
//     description: "Ham and pineapple.",
//     category: "pizza",
//     image: "https://picsum.photos/200?random=13",
//     price: {"small": 5.00, "medium": 6.50, "large": 8.00},
//   ),
//   Product(
//     id: "p14",
//     name: "BBQ Chicken Pizza",
//     description: "Chicken with BBQ sauce.",
//     category: "pizza",
//     image: "https://picsum.photos/200?random=14",
//     price: {"small": 5.50, "medium": 7.00, "large": 8.50},
//   ),
//   Product(
//     id: "p15",
//     name: "Veggie Pizza",
//     description: "Vegetables with cheese.",
//     category: "pizza",
//     image: "https://picsum.photos/200?random=15",
//     price: {"small": 4.20, "medium": 5.80, "large": 7.20},
//   ),

//   // DRINK -----------------------------------------------------
//   Product(
//     id: "p16",
//     name: "Coca Cola",
//     description: "Cold refreshing cola.",
//     category: "drink",
//     image: "https://picsum.photos/200?random=16",
//     price: {"small": 1.00, "medium": 1.20, "large": 1.50},
//   ),
//   Product(
//     id: "p17",
//     name: "Sprite",
//     description: "Lemon-lime soda.",
//     category: "drink",
//     image: "https://picsum.photos/200?random=17",
//     price: {"small": 1.00, "medium": 1.20, "large": 1.50},
//   ),
//   Product(
//     id: "p18",
//     name: "Fanta Orange",
//     description: "Sweet orange soda.",
//     category: "drink",
//     image: "https://picsum.photos/200?random=18",
//     price: {"small": 1.00, "medium": 1.20, "large": 1.50},
//   ),
//   Product(
//     id: "p19",
//     name: "Ice Lemon Tea",
//     description: "Fresh lemon iced tea.",
//     category: "drink",
//     image: "https://picsum.photos/200?random=19",
//     price: {"small": 1.20, "medium": 1.50, "large": 1.80},
//   ),
//   Product(
//     id: "p20",
//     name: "Energy Drink",
//     description: "Strong and energizing.",
//     category: "drink",
//     image: "https://picsum.photos/200?random=20",
//     price: {"small": 1.50, "medium": 1.80, "large": 2.00},
//   ),

//   // COFFEE -----------------------------------------------------
//   Product(
//     id: "p21",
//     name: "Iced Latte",
//     description: "Espresso with cold milk.",
//     category: "coffee",
//     image: "https://picsum.photos/200?random=21",
//     price: {"small": 2.20, "medium": 2.70, "large": 3.20},
//   ),
//   Product(
//     id: "p22",
//     name: "Hot Americano",
//     description: "Brewed espresso with hot water.",
//     category: "coffee",
//     image: "https://picsum.photos/200?random=22",
//     price: {"small": 2.00, "medium": 2.50, "large": 3.00},
//   ),
//   Product(
//     id: "p23",
//     name: "Cappuccino",
//     description: "Rich espresso with frothed milk.",
//     category: "coffee",
//     image: "https://picsum.photos/200?random=23",
//     price: {"small": 2.50, "medium": 3.00, "large": 3.50},
//   ),
//   Product(
//     id: "p24",
//     name: "Mocha",
//     description: "Chocolate coffee mix.",
//     category: "coffee",
//     image: "https://picsum.photos/200?random=24",
//     price: {"small": 2.80, "medium": 3.20, "large": 3.80},
//   ),
//   Product(
//     id: "p25",
//     name: "Caramel Macchiato",
//     description: "Caramel espresso blend.",
//     category: "coffee",
//     image: "https://picsum.photos/200?random=25",
//     price: {"small": 2.80, "medium": 3.20, "large": 3.80},
//   ),

//   // EXTRA -----------------------------------------------------
//   Product(
//     id: "p26",
//     name: "Vanilla Milkshake",
//     description: "Frozen vanilla shake.",
//     category: "drink",
//     image: "https://picsum.photos/200?random=26",
//     price: {"small": 2.00, "medium": 2.50, "large": 3.00},
//   ),
//   Product(
//     id: "p27",
//     name: "Chocolate Milkshake",
//     description: "Rich chocolate shake.",
//     category: "drink",
//     image: "https://picsum.photos/200?random=27",
//     price: {"small": 2.20, "medium": 2.70, "large": 3.20},
//   ),
//   Product(
//     id: "p28",
//     name: "Grilled Chicken Burger",
//     description: "Healthy grilled chicken burger.",
//     category: "burger",
//     image: "https://picsum.photos/200?random=28",
//     price: {"small": 3.50, "medium": 4.20, "large": 5.00},
//   ),
//   Product(
//     id: "p29",
//     name: "Beef Tacos",
//     description: "Mexican beef tacos.",
//     category: "meat",
//     image: "https://picsum.photos/200?random=29",
//     price: {"small": 3.00, "medium": 4.00, "large": 5.00},
//   ),
//   Product(
//     id: "p30",
//     name: "Garlic Bread",
//     description: "Crispy garlic bread.",
//     category: "pizza",
//     image: "https://picsum.photos/200?random=30",
//     price: {"small": 1.50, "medium": 2.00, "large": 2.50},
//   ),
// ];

// // -----------------------------------------------------------
// // FIRESTORE UPLOAD FUNCTION
// // -----------------------------------------------------------
// Future<void> uploadFakeProducts() async {
//   final db = FirebaseFirestore.instance;
//   final productsRef = db.collection('products');

//   for (var product in fakeProductsList) {
//     await productsRef.doc(product.id).set(product.toMap());
//   }
// }

// // -----------------------------------------------------------
// // UI SCREEN
// // -----------------------------------------------------------
// class UploadProductsScreen extends StatefulWidget {
//   @override
//   State<UploadProductsScreen> createState() => _UploadProductsScreenState();
// }

// class _UploadProductsScreenState extends State<UploadProductsScreen> {
//   bool isUploading = false;
//   double progress = 0;

//   Future<void> startUpload() async {
//     setState(() {
//       isUploading = true;
//       progress = 0;
//     });

//     for (int i = 0; i < fakeProductsList.length; i++) {
//       await FirebaseFirestore.instance
//           .collection("products")
//           .doc(fakeProductsList[i].id)
//           .set(fakeProductsList[i].toMap());

//       setState(() {
//         progress = (i + 1) / fakeProductsList.length;
//       });
//     }

//     setState(() => isUploading = false);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Uploaded all 30 products 🎉")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Upload Fake Products"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: isUploading
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(value: progress),
//                   SizedBox(height: 20),
//                   Text("${(progress * 100).toStringAsFixed(0)}%"),
//                 ],
//               )
//             : ElevatedButton(
//                 onPressed: startUpload,
//                 child: Text("Upload 30 Products"),
//               ),
//       ),
//     );
//   }
// }
