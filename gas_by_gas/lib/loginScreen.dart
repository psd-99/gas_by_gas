import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_by_gas/BaseScreen/baseScreen.dart';

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
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            title: const Padding(padding: EdgeInsets.only(left: 20.0)),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
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
                        //const SizedBox(height: 16),
                        Text(
                          "Login",
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            color: Colors.black,
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
                            backgroundColor: Color(0xFF0097B2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _validateAndLogin,
                          child: const Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed:
                              () => Navigator.pushNamed(context, '/signup'),
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF0097B2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextButton(
                  onPressed: () => SystemNavigator.pop(),
                  style: TextButton.styleFrom(foregroundColor: Colors.blueGrey),
                  child: const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 12, color: Color(0xFF0097B2)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
