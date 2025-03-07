import 'package:flutter/material.dart';
import 'package:gas_by_gas/BaseScreen/baseScreen.dart';
import 'package:gas_by_gas/utils/app_colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Align(
                    alignment: Alignment.centerLeft,

                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Welcome To\n',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 24,
                            ),
                          ),
                          TextSpan(
                            text: 'Gas ',
                            style: TextStyle(
                              color: AppColors.buttonColor,
                              fontSize: 24,
                            ),
                          ),
                          TextSpan(
                            text: 'by ',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 24,
                            ),
                          ),
                          TextSpan(
                            text: 'Gas',
                            style: TextStyle(
                              color: AppColors.textWelcome,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 350,
                      width: 350,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Door-step Delivery',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20), // Adds spacing
                        SizedBox(
                          width: double.infinity, // Ensures full width
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 17),
                              backgroundColor: AppColors.buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/request');
                            },
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
