import 'package:get/get.dart';

class DetailController extends GetxController {
  var sizeList = ["S", "M", "L", "XL"];
  var selectedSize = "S".obs;

  var qty = 1.obs;
  var total = 0.0.obs;

  Map<String, dynamic> price = {};

  void initPrice(Map<String, dynamic> productPrice) {
    price = productPrice;
    updateTotal();
  }

  void selectSize(String s) {
    selectedSize.value = s;
    updateTotal();
  }

  void increaseQty() {
    qty.value++;
    updateTotal();
  }

  void decreaseQty() {
    if (qty.value > 1) {
      qty.value--;
      updateTotal();
    }
  }

  void updateTotal() {
    double p = (price[selectedSize.value] as num).toDouble();

    total.value = p * qty.value;
  }
}
