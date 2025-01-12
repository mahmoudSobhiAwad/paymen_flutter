import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_flutter/Features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:payment_flutter/Features/checkout/presentation/views/widgets/my_cart_view_body.dart';
import 'package:payment_flutter/core/widgets/cutom_app_bar.dart';
import 'package:flutter/material.dart';

class MyCartView extends StatelessWidget {
  const MyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'My Cart'),
      body: BlocProvider(
        create: (context) => PaymentCubit(),
        child: const MyCartViewBody(),
      ),
    );
  }
}
