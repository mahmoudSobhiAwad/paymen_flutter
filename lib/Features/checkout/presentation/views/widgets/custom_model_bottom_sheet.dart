import 'package:flutter/material.dart';
import 'package:payment_flutter/Features/checkout/presentation/views/widgets/payment_methods_list_view.dart';
import 'package:payment_flutter/core/widgets/custom_button.dart';

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet(
      {super.key,
      required this.onTap,
      required this.changeIndex,
      required this.currIndex});
  final void Function() onTap;
  final void Function(int) changeIndex;

  final int currIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(
            changeActiveIndex: (int index) {
              changeIndex(index);
            },
            activeIndex: currIndex,
          ),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
            text: 'Continue',
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
