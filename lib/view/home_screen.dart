import 'package:burger_app/model/category.dart';
import 'package:burger_app/model/product.dart';
import 'package:burger_app/service/category_service.dart';
import 'package:burger_app/service/product_services.dart';
import 'package:burger_app/view/card_screen.dart';
import 'package:burger_app/view/detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/route_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(()=>CartScreen());
            },
            icon: Icon(Icons.shopping_cart_outlined),
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder(
            future: productService.getProducts(),
            builder: (context, productSnap) {
              if (productSnap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!productSnap.hasData || productSnap.data!.isEmpty) {
                return Center(child: Text("No products found"));
              }

              final products = productSnap.data!;

              // Load categories AFTER products load
              return FutureBuilder(
                future: CategoryService().getCategories(),
                builder: (context, catSnap) {
                  if (catSnap.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!catSnap.hasData || catSnap.data!.isEmpty) {
                    return Center(child: Text("No categories found"));
                  }

                  final categories = catSnap.data!;

                  return Column(
                    children: [
                      // Slideshow
                      ImageSlideshow(
                        height: 220,
                        isLoop: true,
                        autoPlayInterval: 3000,
                        indicatorColor: Colors.deepOrange,
                        children: [
                          Image.asset(
                            "asset/image/banner1.png",
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            "asset/image/banner2.png",
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),

                      SizedBox(height: 15),

                      // Category Header
                      Row(
                        children: [
                          Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Text("View All"),
                        ],
                      ),

                      SizedBox(height: 10),

                      // CATEGORY LIST
                      SizedBox(
                        height: 95,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            final c = categories[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Container(
                                width: 75,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Expanded(
                                    //   child: Image.network(
                                    //     c.image,
                                    //     fit: BoxFit.contain,
                                    //     errorBuilder: (c, o, e) =>
                                    //         Icon(Icons.broken_image, size: 50),
                                    //   ),
                                    // ),
                                    SizedBox(height: 5),
                                    Text(
                                      c.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 15),

                      // Popular Header
                      Row(
                        children: [
                          Text(
                            "Popular",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Text("View All"),
                        ],
                      ),

                      SizedBox(height: 15),

                      // PRODUCT GRID
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 7 / 10,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final p = products[index];

                          return InkWell(
                            onTap: () {
                              Get.to(DetailScreen(product: p));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.12),
                                    blurRadius: 12,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.network(p.image, height: 130),
                                    SizedBox(height: 10),
                                    Text(
                                      p.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                    ),
                                    Text(
                                      p.description,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                       maxLines: 2,
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${p.price['small']}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.add_circle,
                                          color: Colors.deepOrange,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
