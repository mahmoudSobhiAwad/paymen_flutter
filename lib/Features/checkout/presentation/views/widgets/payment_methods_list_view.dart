import 'package:payment_flutter/Features/checkout/presentation/views/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';

class PaymentMethodsListView extends StatelessWidget {
  const PaymentMethodsListView({
    super.key,
    required this.changeActiveIndex,
    required this.activeIndex,
  });
  final void Function(int index) changeActiveIndex;
  final int activeIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: ListView.builder(
          itemCount: paymentMethodsItems.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () {
                  changeActiveIndex(index);
                },
                child: PaymentMethodItem(
                  isActive: activeIndex == index,
                  image: paymentMethodsItems[index],
                ),
              ),
            );
          }),
    );
  }
}

const List<String> paymentMethodsItems = [
  'assets/images/card.svg',
  'assets/images/paypal.svg'
];
