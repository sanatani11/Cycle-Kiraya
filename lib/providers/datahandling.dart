import 'package:cycle_kiraya/models/address.dart';
import 'package:flutter/material.dart';

class DataHandling extends ChangeNotifier {
  Address? pickupLocation;

  void updatePickupLocationAddress(Address pickupAddress) {
    pickupLocation = pickupAddress;
    notifyListeners();
  }
}
