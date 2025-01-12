import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_flutter/Features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:payment_flutter/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:payment_flutter/Features/checkout/presentation/views/widgets/cart_info_item.dart';
import 'package:payment_flutter/Features/checkout/presentation/views/widgets/custom_model_bottom_sheet.dart';
import 'package:payment_flutter/Features/checkout/presentation/views/widgets/pay_with_paypal.dart';
import 'package:payment_flutter/Features/checkout/presentation/views/widgets/total_price_widget.dart';
import 'package:payment_flutter/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentErrorState) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              state.errMessage ?? "",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.redAccent,
          ));
        } else if (state is PaymentSuccessState) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ThankYouView()));
        }
      },
      builder: (context, state) {
        var bloc = context.read<PaymentCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              Expanded(child: Image.asset('assets/images/basket_image.png')),
              const SizedBox(
                height: 25,
              ),
              const OrderInfoItem(
                title: 'Order Subtotal',
                value: r'42.97$',
              ),
              const SizedBox(
                height: 3,
              ),
              const OrderInfoItem(
                title: 'Discount',
                value: r'0$',
              ),
              const SizedBox(
                height: 3,
              ),
              const OrderInfoItem(
                title: 'Shipping',
                value: r'8$',
              ),
              const Divider(
                thickness: 2,
                height: 34,
                color: Color(0xffC7C7C7),
              ),
              const TotalPrice(title: 'Total', value: r'$50.97'),
              const SizedBox(
                height: 16,
              ),
              CustomButton(
                isLoading: bloc.isLoading,
                text: 'Complete Payment',
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      builder: (context) {
                        return BlocBuilder<PaymentCubit, PaymentState>(
                          bloc: bloc,
                          builder: (context, state) {
                            return PaymentMethodsBottomSheet(
                              onTap: () async {
                                if (bloc.currIndex == 0) {
                                  await bloc.createPaymentInten();
                                } else if (bloc.currIndex == 1) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PaymentWithPayPal()));
                                }
                              },
                              changeIndex: (index) {
                                bloc.changeIndex(index);
                              },
                              currIndex: bloc.currIndex,
                            );
                          },
                        );
                      });
                },
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        );
      },
    );
  }
}
