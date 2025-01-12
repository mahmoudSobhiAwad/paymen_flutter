import 'package:dio/dio.dart';
import 'package:payment_flutter/core/utils/constants/api_keys.dart';

class ApiServices {
  final Dio dioHelper = Dio();

  Future<Response> post(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers,
      String? contentType}) async {
    final result = await dioHelper.post('${StripeApiKeys.baseUrl}/$endPoint',
        queryParameters: data,
        options: Options(
          contentType: contentType,
          headers: headers ??
              {
                "Content-Type": 'application/x-www-form-urlencoded',
                'Authorization': 'Bearer ${StripeApiKeys.secretKey}',
              },
        ));
    return result;
  }
}
