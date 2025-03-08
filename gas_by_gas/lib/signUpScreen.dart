import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas_by_gas/BaseScreen/baseScreen.dart';
import 'package:gas_by_gas/controllers/AuthController.dart';
import 'package:gas_by_gas/loginScreen.dart';
import 'package:gas_by_gas/utils/app_colors.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthController authController = Get.find();

  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String? _selectedTitle;
  String _mobile = '';
  String _email = '';
  String _password = '';
  // ignore: unused_field
  String _confirmPassword = '';
  bool _agreeToTerms = false;
  bool _obscureText = true;
  bool _obscureConfirmText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmText = !_obscureConfirmText;
    });
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    }
    if (value.length < 8 || value.length > 30) {
      return "Password must be 8-30 characters long";
    }
    if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,30}$',
    ).hasMatch(value)) {
      return "Password must include uppercase, lowercase, a number, and a special character";
    }
    return null;
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        authController.phoneNumber = _mobile;
        signInWithPhoneNumber();
        // Create a user with Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);

        // Get the user's unique ID
        String uid = userCredential.user!.uid;

        // Save additional user information to Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'firstName': _firstName,
          'lastName': _lastName,
          'mobile': _mobile,
          'email': _email,
          'title': _selectedTitle,
          'termsAccepted': _agreeToTerms,
          'createdAt': FieldValue.serverTimestamp(), // Track the signup time
        });

        // Navigate back or to a different screen after successful sign-up
        //ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/otpScreen');
      } catch (e) {
        // Show an error dialog if sign-up fails
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text("Sign Up Failed"),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK"),
                  ),
                ],
              ),
        );
      }
    }
  }

  Future<void> signInWithPhoneNumber() async {
    await authController.sendOTP(); // This reuses the sendOTP function
  }

  Widget build(BuildContext context) {
    return BaseScreen(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   leading: IconButton(
          //     icon: const Icon(Icons.arrow_back),
          //     onPressed: () => Navigator.pop(context),
          //   ),
          //   title: const Text(
          //     "Sign Up",
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          //   backgroundColor: Colors.white, // Customize your app bar color
          // ),
          body: Padding(
            padding: const EdgeInsets.all(0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo_Signup.png',
                          height: 124,
                          width: 209,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Let’s Create Account",
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ), // Dummy Company Logo
                  ),
                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Who are you ?",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ), // Adjust height
                    ),
                    value: _selectedTitle,
                    dropdownColor: AppColors.background,
                    items:
                        ["Mr", "Mrs", "Miss"]
                            .map(
                              (title) => DropdownMenuItem(
                                value: title,
                                child: Text(title),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() => _selectedTitle = value),
                    validator:
                        (value) => value == null ? "Select a title" : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "First Name",
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        // Prevent border color change
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 15,
                      ),
                    ),
                    onChanged: (value) => _firstName = value,
                    validator:
                        (value) =>
                            value!.isEmpty ? "Enter your first name" : null,
                  ),

                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Last Name",
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        // Prevent border color change
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onChanged: (value) => _lastName = value,
                    validator:
                        (value) =>
                            value!.isEmpty ? "Enter your last name" : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Mobile No",
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        // Prevent border color change
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onChanged: (value) => _mobile = value,
                    validator:
                        (value) =>
                            value!.isEmpty ? "Enter your mobile number" : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        // Prevent border color change
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      floatingLabelStyle: TextStyle(color: Colors.black),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onChanged: (value) => _email = value,
                    validator:
                        (value) => value!.isEmpty ? "Enter your email" : null,
                  ),

                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        // Prevent border color change
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                      floatingLabelStyle: const TextStyle(color: Colors.black),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onChanged: (value) => _password = value,
                    validator: _validatePassword,
                    obscureText: _obscureText,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        // Prevent border color change
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _toggleConfirmPasswordVisibility,
                      ),
                      floatingLabelStyle: const TextStyle(color: Colors.black),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                    onChanged: (value) => _confirmPassword = value,
                    validator:
                        (value) =>
                            value != _password
                                ? "Passwords do not match"
                                : null,
                    obscureText: _obscureConfirmText,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreeToTerms,
                        onChanged:
                            (value) => setState(() => _agreeToTerms = value!),
                        activeColor: AppColors.buttonColor,
                      ),
                      const Text("Agree with Terms & Conditions"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: const Text(
                      "Already Have an account?  Login  ",
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      backgroundColor: AppColors.buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _agreeToTerms ? _signUp : null,
                    child: const Text(
                      "Get started",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
