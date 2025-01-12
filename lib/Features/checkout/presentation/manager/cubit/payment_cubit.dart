import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:payment_flutter/Features/checkout/data/models/payment_intent_model.dart';
import 'package:payment_flutter/Features/checkout/data/repos/payment_stripe_repo_impl.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  final PaymentStripeRepoImpl paymentStripeRepoImpl = PaymentStripeRepoImpl();
  int currIndex = 0;
  bool isLoading = false;
  Future<void> createPaymentInten() async {
    if (!isLoading) {
      isLoading = true;
      emit(PaymentLoadingState());
      final result = await paymentStripeRepoImpl.makePayment(
          paymentIntentModel: PaymentIntentModel(
              amount: "2000",
              currenceyCode: "usd",
              customerId: 'cus_RZYnrgsOauRMIj'));
      result.fold((model) {
        isLoading = false;
        emit(PaymentSuccessState());
      }, (failure) {
        isLoading = false;
        log(failure.errorMessage);
        emit(PaymentErrorState(errMessage: failure.errorMessage));
      });
    }
  }

  void changeIndex(index) {
    currIndex = index;
    emit(ChangeCurrIndexState());
  }
}
