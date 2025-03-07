import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_by_gas/BaseScreen/baseScreen.dart';
import 'package:gas_by_gas/utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _validateAndLogin() {
    // Authentication logic goes here
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              height: 230,
                              width: 230,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Login",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 62),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Mobile",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) => _email = value,
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? "Please enter your user name"
                                    : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                        onChanged: (value) => _password = value,
                        validator:
                            (value) =>
                                value!.isEmpty
                                    ? "Please enter your password"
                                    : null,
                        obscureText: _obscureText,
                      ),
                      const SizedBox(height: 62),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 17),
                          backgroundColor: AppColors.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _validateAndLogin,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed:
                            () => Navigator.pushNamed(context, '/welcome'),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.buttonColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 12, color: AppColors.buttonColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
