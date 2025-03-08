import 'package:flutter/material.dart';
import 'package:gas_by_gas/controllers/AuthController.dart';
import 'package:gas_by_gas/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final AuthController authController = Get.find();
  TextEditingController otpController = TextEditingController();


  Future<void> confirmSignIn(String otp) async {
    await authController.verifyOTP(otp); // This reuses the verifyOTP function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double remainingHeight =
              constraints.maxHeight - MediaQuery.of(context).viewInsets.bottom;
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: remainingHeight),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: 24.0,
                ),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Fix: Prevent infinite height issue
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/logo.png')),
                    const Text('Enter OTP', style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        PinCodeTextField(
                          controller: otpController,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          appContext: context,
                          length: 6,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            borderWidth: 1.0,
                            fieldHeight: 49,
                            fieldWidth: 53,
                            activeColor: Colors.black,
                            inactiveColor: AppColors.grey,
                            selectedColor: AppColors.highlight,
                          ),
                          onChanged: (value) {},
                        ),
                        Row(
                          children: [
                            Text(
                              "Didn't Get Code? Try Again",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.highlight,
                              ),
                            ),
                            Text(
                              "  00:59",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Try Another Number',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.grey,
                          ), // Normal state
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.highlight,
                          ), // When focused
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          await confirmSignIn(otpController.text);
                          if (authController.isNumberVerified) {
                            Navigator.pushNamed(context, '/login');
                          }
                          else {
                            otpController.clear();
                            showDialog(
                              // ignore: use_build_context_synchronously
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                title: const Text("Incorrect OTP"),
                                content: Text("Please enter the correct otp"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Spacer(),
                    const Text(
                      'Verify your identity securely. Enter the OTP sent to your registered phone number to proceed.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
