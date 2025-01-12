import 'dart:convert';

import 'package:payment_flutter/Features/checkout/data/models/created_payment_intent_model/tip.dart';


class AmountDetails {
  Tip? tip;

  AmountDetails({this.tip});

  factory AmountDetails.fromMap(Map<String, dynamic> data) => AmountDetails(
        tip: data['tip'] == null
            ? null
            : Tip.fromJson(data['tip'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'tip': tip?.toJson(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AmountDetails].
  factory AmountDetails.fromJson(String data) {
    return AmountDetails.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AmountDetails] to a JSON string.
  String toJson() => json.encode(toMap());
}
