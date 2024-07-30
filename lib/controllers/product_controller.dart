import 'package:fire_ecomm/controllers/cart_controller.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/firebase_service.dart';

class ProductController extends GetxController {
  FirebaseService firebaseService = FirebaseService();
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() async {
    isLoading.value = true;
    products.value = await firebaseService.getProducts();
    isLoading.value = false;
  }

  void addToCart(ProductModel product) {
    Get.find<CartController>().addToCart(product);
  }
}
