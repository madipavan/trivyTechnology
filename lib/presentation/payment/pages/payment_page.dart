import 'package:flutter/material.dart';
import 'package:trivytech/core/configs/themes/app_colors.dart';
import 'package:trivytech/presentation/payment/widget/card_details.dart';
import 'package:trivytech/presentation/payment/widget/gradient_border_btn.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "select payment mode",
                style: TextStyle(
                    letterSpacing: -0.17,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "choose your preferred payment method to make payment.",
                style: TextStyle(
                    color: AppColors.grey,
                    letterSpacing: -0.17,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GradientBorderBtn(
                    colorsList: [
                      Colors.white,
                      Colors.white.withAlpha(1),
                    ],
                    onPressed: () {},
                    label: "pay",
                    labelColor: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GradientBorderBtn(
                    colorsList: [
                      AppColors.primary,
                      AppColors.primary.withAlpha(1)
                    ],
                    onPressed: () {},
                    label: "card",
                    labelColor: AppColors.primary,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "YOUR DIGITAL DEBIT CARD",
                style: TextStyle(
                    color: AppColors.grey.withAlpha(80),
                    letterSpacing: -0.17,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
              CardDetails(),
            ],
          ),
        ),
      ),
    ));
  }
}
