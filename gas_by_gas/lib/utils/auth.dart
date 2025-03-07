import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> sendOTP(String phoneNumber) async {
  await _auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      // Auto-sign in (if the OTP is automatically detected)
      await _auth.signInWithCredential(credential);
      print("Phone number automatically verified and user signed in");
    },
    verificationFailed: (FirebaseAuthException e) {
      print("Verification Failed: ${e.message}");
    },
    codeSent: (String verificationId, int? resendToken) {
      print("OTP Sent: $verificationId");
      // Store verificationId and prompt user for OTP input
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      print("Code retrieval timeout");
    },
  );
}


Future<void> verifyOTP(String verificationId, String smsCode) async {
  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    UserCredential userCredential = await _auth.signInWithCredential(credential);
    print("User Signed Up Successfully: ${userCredential.user!.uid}");
  } catch (e) {
    print("Error: $e");
  }
}


Future<void> signInWithPhoneNumber(String phoneNumber) async {
  await sendOTP(phoneNumber); // This reuses the sendOTP function
}


Future<void> confirmSignIn(String verificationId, String otp) async {
  await verifyOTP(verificationId, otp); // This reuses the verifyOTP function
}


Future<void> logout() async {
  await _auth.signOut();
  print("User Logged Out");
}
