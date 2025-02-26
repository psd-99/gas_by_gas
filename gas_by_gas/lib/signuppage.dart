import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _gender = '';
  String _mobile = '';
  String _email = '';
  String _password = '';
  // ignore: unused_field
  String _confirmPassword = '';
  bool _agreeToTerms = false;
  String? _selectedCountry;
  List<String> _countries = [];

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    final response = await http
        .get(Uri.parse("https://restcountries.com/v3.1/all?fields=name"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        _countries =
            data.map((country) => country['name']['common'] as String).toList();
      });
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    }
    if (value.length < 8 || value.length > 30) {
      return "Password must be 8-30 characters long";
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,30}$')
        .hasMatch(value)) {
      return "Password must include uppercase, lowercase, a number, and a special character";
    }
    return null;
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create a user with Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);

        // Get the user's unique ID
        String uid = userCredential.user!.uid;

        // Save additional user information to Firestore
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'firstName': _firstName,
          'lastName': _lastName,
          'gender': _gender,
          'mobile': _mobile,
          'email': _email,
          'country': _selectedCountry,
          'termsAccepted': _agreeToTerms,
          'createdAt': FieldValue.serverTimestamp(), // Track the signup time
        });

        // Navigate back or to a different screen after successful sign-up
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } catch (e) {
        // Show an error dialog if sign-up fails
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Sign Up",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey, // Customize your app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Icon(Icons.business,
                    size: 100, color: Colors.blueGrey), // Dummy Company Logo
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onChanged: (value) => _firstName = value,
                validator: (value) =>
                    value!.isEmpty ? "Enter your first name" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onChanged: (value) => _lastName = value,
                validator: (value) =>
                    value!.isEmpty ? "Enter your last name" : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    "Gender: ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Radio(
                    value: "Male",
                    groupValue: _gender,
                    onChanged: (value) =>
                        setState(() => _gender = value.toString()),
                  ),
                  const Text("Male"),
                  Radio(
                    value: "Female",
                    groupValue: _gender,
                    onChanged: (value) =>
                        setState(() => _gender = value.toString()),
                  ),
                  const Text("Female"),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Mobile No",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onChanged: (value) => _mobile = value,
                validator: (value) =>
                    value!.isEmpty ? "Enter your mobile number" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onChanged: (value) => _email = value,
                validator: (value) =>
                    value!.isEmpty ? "Enter your email" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Select Country",
                  border: OutlineInputBorder(),
                ),
                value: _selectedCountry,
                items: _countries
                    .map((country) =>
                        DropdownMenuItem(value: country, child: Text(country)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedCountry = value),
                validator: (value) => value == null ? "Select a country" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onChanged: (value) => _password = value,
                validator: _validatePassword,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onChanged: (value) => _confirmPassword = value,
                validator: (value) =>
                    value != _password ? "Passwords do not match" : null,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) =>
                        setState(() => _agreeToTerms = value!),
                  ),
                  const Text("Agree with Terms & Conditions"),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _agreeToTerms ? _signUp : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blueGrey, // Customize your button color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text("Sign Up"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
