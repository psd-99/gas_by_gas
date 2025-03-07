import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gas_by_gas/deliveryScreen.dart';
import 'package:gas_by_gas/paymentScreen.dart';
import 'package:gas_by_gas/splashScreen.dart';
import 'package:gas_by_gas/loginScreen.dart';
import 'package:gas_by_gas/signUpScreen.dart';
import 'package:gas_by_gas/requestScreen.dart';
import 'package:gas_by_gas/welcomeScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gas_by_gas/screens/otp/otp_main_screen.dart';
import 'package:gas_by_gas/utils/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
