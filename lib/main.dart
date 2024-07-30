import 'package:fire_ecomm/bindings/initial_binding.dart';
import 'package:fire_ecomm/views/auth_redirect.dart';
import 'package:fire_ecomm/views/login_page.dart';
import 'package:fire_ecomm/views/products_page.dart';
import 'package:fire_ecomm/views/verification_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Fire Ecomm",
      initialBinding: InitialBinding(),
      home: AuthRedirect(),
      routes: {
        '/login': (context) => LoginPage(),
        '/products': (context) => ProductPage(),
        '/verification': (context) =>
            VerificationPage(verificationId: Get.arguments),
      },
    );
  }
}
