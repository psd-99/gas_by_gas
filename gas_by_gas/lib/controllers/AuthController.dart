import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxString phoneNumber = "".obs;
  RxString verificationId = "".obs;


  Future<void> sendOTP() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber.value,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-sign in (only on some devices)
        await _auth.signInWithCredential(credential);
        print("Auto-sign-in successful");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification Failed: ${e.message}");
      },
      codeSent: (String id, int? resendToken) {
        verificationId.value = id; // Store verification ID
        print("OTP Sent. Verification ID: $id");
      },
      codeAutoRetrievalTimeout: (String id) {
        verificationId.value = id;
        print("OTP Timeout. Verification ID: $id");
      },
    );
  }

  Future<void> verifyOTP(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: smsCode,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      print("User Signed In: ${userCredential.user!.uid}");
    } catch (e) {
      print("Error: $e");
    }
  }


  Future<void> logout() async {
    await _auth.signOut();
    print("User Logged Out");
  }
}