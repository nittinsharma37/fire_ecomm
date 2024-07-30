import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../controllers/auth_controller.dart';
import '../models/product_model.dart';
import '../widgets/loader.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [],
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(child: Text('No items in cart'));
        }

        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            final product = cartController.cartItems[index];
            return ListTile(
              title: Text(product.name!),
              subtitle: Text('₹${product.price!}'),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () {
                  cartController.removeFromCart(product);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
