import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Future<Map<String, dynamic>> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc.data() as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => SystemNavigator.pop()),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading user data."));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No user data available."));
          } else {
            var userData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0), // Add padding
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.business,
                      size: 100,
                      color: Colors.blueGrey,
                    ),
                    Text(
                      "Welcome, ${userData['firstName']} ${userData['lastName']}!",
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                        height: 16), // More space for better readability
                    Text("Email: ${userData['email']}",
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    Text("Mobile No: ${userData['mobile']}",
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    Text("Gender: ${userData['gender']}",
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 8),
                    Text("Country: ${userData['country']}",
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
