import 'package:fire_ecomm/models/user_model.dart';
import 'package:fire_ecomm/views/products_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import 'login_page.dart';

class AuthRedirect extends StatelessWidget {
  const AuthRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return FutureBuilder<UserModel?>(
      future: authController.checkAuthStatus(), // Check auth status
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator()); // Loader while checking auth
        } else if (snapshot.hasData) {
          return ProductPage(); // User is logged in
        } else {
          return LoginPage(); // User is not logged in
        }
      },
    );
  }
}
