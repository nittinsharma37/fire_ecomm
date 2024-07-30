import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  Future<void> saveCart(List<ProductModel> cartItems) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final cartData = cartItems.map((product) => product.toJson()).toList();
      await _firestore
          .collection('carts')
          .doc(user.uid)
          .set({'products': cartData});
    }
  }

  Future<List<ProductModel>> getProducts() async {
    final querySnapshot = await _firestore.collection('products').get();
    print("snapshot --->>> ${querySnapshot.docs.toList().toString()}");
    return querySnapshot.docs.map((doc) {
      print("doc --- > ${doc.data()}");
      return ProductModel.fromJson(doc.data());
    }).toList();
  }

  Future<List<ProductModel>> getCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('carts').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          final products = (data['products'] as List)
              .map((product) => ProductModel.fromJson(product))
              .toList();
          return products;
        }
      }
    }
    return [];
  }
}
