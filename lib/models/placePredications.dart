import 'package:flutter/material.dart';

class PlacePredictions {
  late String secondaryText;
  late String mainText;
  late String placeId;
  PlacePredictions({
    required this.secondaryText,
    required this.mainText,
    required this.placeId,
  });
  PlacePredictions.fromJson(Map<String, dynamic> json) {
    secondaryText = json["address_line2"];
    mainText = json["address_line1"];
    placeId = json["place_id"];
  }
}
