import 'package:dartz/dartz.dart';
import 'package:payment_flutter/Features/checkout/data/models/payment_intent_model.dart';
import 'package:payment_flutter/Features/checkout/data/repos/payment_stripe_repo.dart';
import 'package:payment_flutter/core/utils/error/error_handling_api.dart';
import 'package:payment_flutter/core/utils/functions/stripe_sevices.dart';

class PaymentStripeRepoImpl implements PaymentStripeRepo {
  final StripServices stripServices = StripServices();
  @override
  Future<Either<void, Failure>> makePayment(
      {required PaymentIntentModel paymentIntentModel}) async {
    try {
      await stripServices.makePayment(paymentIntentModel: paymentIntentModel);
      return left(null);
    } catch (e) {
      return right(Failure(errorMessage: e.toString()));
    }
  }
}
