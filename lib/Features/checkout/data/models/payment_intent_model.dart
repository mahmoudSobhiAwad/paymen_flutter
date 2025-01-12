class PaymentIntentModel {
  String amount;
  String currenceyCode;
  String customerId;
  PaymentIntentModel(
      {required this.amount,
      required this.currenceyCode,
      required this.customerId});

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currenceyCode,
      'customer': customerId,
    };
  }
}
