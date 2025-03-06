import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const BaseScreen({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.9, // 80% of a max width (adjustable)
            ),
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
