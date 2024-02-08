import 'package:cycle_kiraya/assistant/request.dart';
import 'package:geolocator/geolocator.dart';

class AssistantMethod {
  static Future<String> searchCoordinatesAddress(Position position) async {
    String locationAddress = "";
    String url =
        "https://api.geoapify.com/v1/geocode/reverse?lat=${position.latitude}&lon=${position.longitude}&apiKey=85a5177ec1d9420da018f1047af77673";
    var response = await RequestAssistant.getAddress(url);

    if (response != "failed!") {
      locationAddress = response['features'][0]['properties']['formatted'];
    }
    return locationAddress;
  }
}
