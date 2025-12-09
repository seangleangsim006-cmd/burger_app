import 'package:burger_app/controller/card_controller.dart';
import 'package:burger_app/controller/detail_controller.dart';
import 'package:burger_app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailController());
    CartController cartController = Get.put(CartController());
    controller.initPrice(product.price);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [Icon(Icons.favorite_border, color: Colors.red)],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.network(product.image, height: 300)),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${controller.total.value.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Text(
                "${product.description} Loaded with double melted cheese on top of a tender beef patty. Creamy, cheesy, and perfect for anyone who can’t get enough of cheese.Loaded with double melted cheese on top of a tender beef patty. Creamy, cheesy, and perfect for anyone who can’t get enough of cheese.",
              ),
              SizedBox(height: 20),
              Text(
                "Choose Size",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              // SIZE SELECTION
              SizedBox(
                height: 65,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.sizeList.length,
                  itemBuilder: (context, index) {
                    String s = controller.sizeList[index];
                    return GestureDetector(
                      onTap: () => controller.selectSize(s),
                      child: Container(
                        margin: EdgeInsets.only(right: 10, top: 15),
                        width: 50,
                        decoration: BoxDecoration(
                          color: controller.selectedSize.value == s
                              ? Colors.deepOrange
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text(
                            s,
                            style: TextStyle(
                              color: controller.selectedSize.value == s
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // MINUS
                  GestureDetector(
                    onTap: () => controller.decreaseQty(),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "-",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 15),
                  Text(
                    "${controller.qty}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 15),

                  // PLUS
                  GestureDetector(
                    onTap: () => controller.increaseQty(),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "+",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              // ORDER NOW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 160,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.deepOrange),
                    ),
                    child: Center(
                      child: Text(
                        "Order Now",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

               InkWell(
  onTap: () {
    final cart = Get.find<CartController>();

    cart.addToCart(
      productId: product.id,
      name: product.name,
      image: product.image,
      price: 10,
      size: 'M',
      category:product.category,
      qty: controller.qty.value,
    );
  },
  child: Container(
    width: 180,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.deepOrange,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text("Add to Cart",
          style: TextStyle(color: Colors.white, fontSize: 20)),
    ),
  ),
)

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
