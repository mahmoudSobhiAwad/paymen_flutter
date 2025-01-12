import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_flutter/Features/checkout/presentation/views/my_cart_view.dart';
import 'package:flutter/material.dart';
import 'package:payment_flutter/core/utils/constants/api_keys.dart';

void main() async {
  Stripe.publishableKey = StripeApiKeys.stripePublishKey;

  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}
