import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/firebase_service.dart';

class CartController extends GetxController {
  FirebaseService firebaseService = FirebaseService();
  var cartItems = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void addToCart(ProductModel product) {
    cartItems.add(product);
    saveCart();
    Get.snackbar("Success", "${product.name} is added to cart",
        snackPosition: SnackPosition.BOTTOM);
  }

  void removeFromCart(ProductModel product) {
    cartItems.remove(product);
    saveCart();
    Get.snackbar("Success", "${product.name} is removed from the cart",
        snackPosition: SnackPosition.BOTTOM);
  }

  void saveCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await firebaseService.saveCart(cartItems);
    }
  }

  void loadCart() async {
    cartItems.value = await firebaseService.getCart();
  }
}
