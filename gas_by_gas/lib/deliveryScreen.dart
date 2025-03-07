import 'package:flutter/material.dart';
import 'package:gas_by_gas/BaseScreen/BaseScreen.dart';
import 'package:gas_by_gas/utils/app_colors.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
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

                    child: Text(
                      'Delivery',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(height: 60),
                  Center(
                    child: Image.asset(
                      'assets/images/delivery.png',
                      height: 248,
                      width: 248,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    'Sit back and relax !',
                  ),
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      children: [
                        const Text(
                          style: TextStyle(fontSize: 12),
                          'Your Gas Is On The Way.\nTrack Your Delivery In Real-Time And Get Ready\nFor A Seamless Experience.',
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
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.textSecondary,
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
