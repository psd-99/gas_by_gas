import 'package:flutter/material.dart';
import 'package:gas_by_gas/deliveryScreen.dart';
import 'package:gas_by_gas/paymentScreen.dart';
import 'package:gas_by_gas/splashScreen.dart';
import 'package:gas_by_gas/loginScreen.dart';
import 'package:gas_by_gas/signUpScreen.dart';
import 'package:gas_by_gas/requestScreen.dart';
import 'package:gas_by_gas/welcomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GasbyGas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => const LoginScreen(),
        '/signup': (BuildContext context) => const SignUpScreen(),
        '/request': (BuildContext context) => const RequestScreen(),
        '/payment': (BuildContext context) => const PaymentScreen(),
        '/delivery': (BuildContext context) => const DeliveryScreen(),
        '/welcome': (BuildContext context) => const WelcomeScreen(),

        // '/home': (BuildContext context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
