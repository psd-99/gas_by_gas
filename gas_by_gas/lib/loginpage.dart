import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          // ignore: use_build_context_synchronously
          .then((_) => Navigator.of(context).pushReplacementNamed('/home'))
          // ignore: body_might_complete_normally_catch_error
          .catchError((e) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Login Failed"),
            content: Text(e.message ?? "Invalid credentials."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "Login",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.business,
                      size: 100,
                      color: Colors.blueGrey,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Welcome Back!",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Please login to continue",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "User Name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) => _email = value,
                validator: (value) =>
                    value!.isEmpty ? "Please enter your user name" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) => _password = value,
                validator: (value) =>
                    value!.isEmpty ? "Please enter your password" : null,
                obscureText: true,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _validateAndLogin,
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                child: const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blueGrey,
                ),
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
