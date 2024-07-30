import 'package:fire_ecomm/views/login_page.dart';
import 'package:fire_ecomm/views/products_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseService firebaseService = FirebaseService();
  final GetStorage box = GetStorage();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus(); // Check auth status on initialization
  }

  Future<UserModel?> checkAuthStatus() async {
    final userJson = box.read('user');
    if (userJson != null) {
      return UserModel.fromJson(userJson);
    }
    return null;
  }

  void phoneLogin(String phoneNumber) async {
    print("user phonenumber ---->>> ${phoneNumber}");
    isLoading.value = true;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          await _saveUser(userCredential.user!);
          isLoading.value = false;
          Get.offAll(ProductPage());
        },
        verificationFailed: (FirebaseAuthException e) {
          print("erorr 42 --->>> ${e}");
          isLoading.value = false;
          Get.snackbar("Error", e.message!);
        },
        codeSent: (String verificationId, int? resendToken) {
          isLoading.value = false;
          Get.toNamed('/verification', arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("error 54 ---> $e");
    }
  }

  void verifyCode(String verificationId, String smsCode) async {
    isLoading.value = true;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    UserCredential userCredential = await auth.signInWithCredential(credential);
    await _saveUser(userCredential.user!);
    isLoading.value = false;
    Get.offAll(ProductPage());
  }

  Future<void> _saveUser(User user) async {
    UserModel userModel = UserModel(
      uid: user.uid,
      phoneNumber: user.phoneNumber!,
    );
    await firebaseService.saveUser(userModel);
    box.write('user', userModel.toJson());
  }

  void logout() async {
    await auth.signOut();
    box.remove('user');
    Get.offAll(LoginPage());
  }
}
