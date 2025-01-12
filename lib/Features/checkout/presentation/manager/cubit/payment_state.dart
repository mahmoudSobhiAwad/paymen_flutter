part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentLoadingState extends PaymentState {}

final class PaymentErrorState extends PaymentState {
  final String?errMessage;
  PaymentErrorState({this.errMessage});
}

final class PaymentSuccessState extends PaymentState {}

final class ChangeCurrIndexState extends PaymentState {}
