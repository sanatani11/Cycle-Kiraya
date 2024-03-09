import 'package:cycle_kiraya/assistant/request.dart';
import 'package:cycle_kiraya/models/address.dart';
import 'package:cycle_kiraya/providers/datahandling.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AssistantMethod {
  static Future<String> searchCoordinatesAddress(
      Position position, context) async {
    String locationAddress = "";
    String url =
        "https://api.geoapify.com/v1/geocode/reverse?lat=${position.latitude}&lon=${position.longitude}&apiKey=85a5177ec1d9420da018f1047af77673";
    var response = await RequestAssistant.getAddress(url);

    if (response != "failed!") {
      locationAddress = response['features'][0]['properties']['formatted'];

      Address userPickupAddress = Address(
          placeFormattedAddress: locationAddress,
          placeId: "place",
          placeName: locationAddress,
          lat: position.latitude,
          lng: position.longitude);
      Provider.of<DataHandling>(context, listen: false)
          .updatePickupLocationAddress(userPickupAddress);
    }
    return locationAddress;
  }

  void obtainPlaceDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    var fromWaypoint = [initialPosition.latitude, initialPosition.longitude];
    var toWaypoint = [finalPosition.latitude, finalPosition.longitude];
    String getDirectionUrl =
        "https://api.geoapify.com/v1/routing?waypoints=${fromWaypoint.join(',')}|${toWaypoint.join(',')}&mode=drive&details=instruction_details&apiKey=03298a44ba394f6784de323e34b18bb8";
    var res = await RequestAssistant.getAddress(getDirectionUrl);
    if (res == "failed") return;
  }
}
