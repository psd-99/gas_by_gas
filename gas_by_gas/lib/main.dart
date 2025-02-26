import '../homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../signuppage.dart';
import 'loginpage.dart';
import 'splash_screen.dart'; // Import the splash screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyC6O6MK0AqeDfSQZ1qe88Y6z-mJocOJYR4",
      appId: "1:465567070870:android:02520e6b11f79295ade0b7",
      messagingSenderId: "664184116638",
      projectId: "mydemoapp-88726",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABC Company',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const LoginScreen(),
        '/signup': (BuildContext context) => const SignUpScreen(),
        '/home': (BuildContext context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
