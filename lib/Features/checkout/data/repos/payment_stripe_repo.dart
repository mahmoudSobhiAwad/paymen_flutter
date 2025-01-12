import 'package:dartz/dartz.dart';
import 'package:payment_flutter/Features/checkout/data/models/payment_intent_model.dart';
import 'package:payment_flutter/core/utils/error/error_handling_api.dart';

abstract class PaymentStripeRepo {
  Future<Either<void, Failure>> makePayment(
      {required PaymentIntentModel paymentIntentModel});
}
