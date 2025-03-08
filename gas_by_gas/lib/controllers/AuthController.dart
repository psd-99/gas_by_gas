import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String phoneNumber = "";
  String verificationId = "";
  bool isNumberVerified = false;


  Future<void> sendOTP() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-sign in (only on some devices)
        await _auth.signInWithCredential(credential);
        print("Auto-sign-in successful");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification Failed: ${e.message}");
      },
      codeSent: (String id, int? resendToken) {
        verificationId = id; // Store verification ID
        print("OTP Sent. Verification ID: $id");
      },
      codeAutoRetrievalTimeout: (String id) {
        verificationId = id;
        print("OTP Timeout. Verification ID: $id");
      },
    );
  }

  Future<void> verifyOTP(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      print("User Signed In: ${userCredential.user!.uid}");
      isNumberVerified = true;
    } catch (e) {
      print("Error: $e");
    }
  }


  Future<void> logout() async {
    await _auth.signOut();
    print("User Logged Out");
  }
}