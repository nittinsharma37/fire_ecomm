import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class VerificationPage extends StatelessWidget {
  final String verificationId;
  final TextEditingController codeController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  VerificationPage({required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verification')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codeController,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Obx(() {
                if (authController.isLoading.value) {
                  return CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    authController.verifyCode(
                        verificationId, codeController.text);
                  },
                  child: Text('Verify'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
