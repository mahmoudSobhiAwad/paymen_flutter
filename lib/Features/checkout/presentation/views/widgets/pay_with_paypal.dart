import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment_flutter/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:payment_flutter/core/utils/constants/api_keys.dart';

class PaymentWithPayPal extends StatelessWidget {
  const PaymentWithPayPal({super.key});

  @override
  Widget build(BuildContext context) {
    return PaypalCheckoutView(
      note: "payer note",
      sandboxMode: true,
      clientId: PayPalApiKeys.clientId,
      secretKey: PayPalApiKeys.secretKey,
      transactions: const [
        {
          "amount": {
            "total": '70',
            "currency": "USD",
            "details": {
              "subtotal": '70',
              "shipping": '0',
              "shipping_discount": 0
            }
          },
        }
      ],
      onSuccess: (Map params) async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ThankYouView()));
      },
      onError: (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      },
      onCancel: () {
        Navigator.pop(context);
      },
    );
  }
}
