import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_flutter/Features/checkout/data/models/created_payment_intent_model/created_payment_intent_model.dart';
import 'package:payment_flutter/Features/checkout/data/models/customer_ephemeral_model.dart';
import 'package:payment_flutter/Features/checkout/data/models/payment_intent_model.dart';
import 'package:payment_flutter/core/utils/constants/api_keys.dart';
import 'package:payment_flutter/core/utils/functions/api_services.dart';

class StripServices {
  final ApiServices apiServices = ApiServices();
  final Stripe stripe = Stripe.instance;
  Future<CreatedPaymentIntentModel> createPaymentIntent(
      {required PaymentIntentModel paymentIntentModel}) async {
    try {
      final result = await apiServices.post(
          endPoint: 'payment_intents', data: paymentIntentModel.toJson());
      return CreatedPaymentIntentModel.fromMap(result.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> initPaymentSheet(CreatedPaymentIntentModel model,
      {CustomerEphemeralModel? customerEphemeralModel}) async {
    await stripe.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Set to true for custom flow
        customFlow: false,
        // Main params
        merchantDisplayName: "Mahmoud sobhi",
        paymentIntentClientSecret: model.clientSecret,
        // Customer keys
        customerEphemeralKeySecret: customerEphemeralModel?.secret,
        customerId: customerEphemeralModel?.associatedObjects?.first.id,
      ),
    );
  }

  Future<void> showPaymentSheet() async {
    await stripe.presentPaymentSheet();
  }

  Future<void> makePayment(
      {required PaymentIntentModel paymentIntentModel}) async {
    var intentPaymentModel =
        await createPaymentIntent(paymentIntentModel: paymentIntentModel);
    var customerEphemeralModel =
        await createEmpheralKey(paymentIntentModel: paymentIntentModel);
    await initPaymentSheet(intentPaymentModel,
        customerEphemeralModel: customerEphemeralModel);
    await stripe.presentPaymentSheet();
  }

  Future<CustomerEphemeralModel> createEmpheralKey(
      {required PaymentIntentModel paymentIntentModel}) async {
    try {
      final result = await apiServices.post(
          headers: {
            "Stripe-Version": '2024-12-18.acacia',
            "Content-Type": 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer ${StripeApiKeys.secretKey}',
          },
          endPoint: 'ephemeral_keys',
          data: {'customer': paymentIntentModel.customerId});
      return CustomerEphemeralModel.fromJson(result.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
