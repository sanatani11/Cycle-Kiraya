import 'package:cycle_kiraya/models/location.dart';
import 'dart:math';

const availableLocation = [
  Location(
    id: 'shop1',
    lat: 26.121737774894275,
    lng: 85.35953691611077,
  ),
  Location(
    id: 'shop2',
    lat: 23.789020348157266,
    lng: 86.41639835712827,
  ),
  Location(
    id: 'shop3',
    lat: 23.78994897414398,
    lng: 86.42716883539151,
  ),
  Location(
    id: 'shop4',
    lat: 23.790555461722683,
    lng: 86.42620079795802,
  ),
  Location(
    id: 'shop5',
    lat: 23.78744806228058,
    lng: 86.42265729939348,
  ),
  Location(
    id: 'shop6',
    lat: 23.788441104894005,
    lng: 86.41659703371398,
  ),
  Location(
    id: 'shop7',
    lat: 23.786795016894846,
    lng: 86.4174916861077,
  ),
  Location(
    id: 'shop8',
    lat: 23.787695976678393,
    lng: 86.41873097878656,
  ),
  Location(
    id: 'shop9',
    lat: 23.818813101815064,
    lng: 86.4366364015063,
  ),
  Location(
    id: 'shop10',
    lat: 23.815999989571278,
    lng: 86.44311276374769,
  ),
  Location(
    id: 'shop11',
    lat: 23.811090382196582,
    lng: 86.44167151085495,
  ),
];

class LocationUtils {
  static Location findNearestShop(Location location) {
    double minPickupDistance = double.infinity;
    Location? result;

    for (var shop in availableLocation) {
      double pickupDistance = calculateDistance(location, shop);
      if (pickupDistance < minPickupDistance) {
        minPickupDistance = pickupDistance;
        result = shop;
      }
    }

    return result!;
  }

  static double calculateDistance(Location location1, Location location2) {
    const double earthRadius = 6371; // in kilometers
    double lat1 = degreesToRadians(location1.lat);
    double lon1 = degreesToRadians(location1.lng);
    double lat2 = degreesToRadians(location2.lat);
    double lon2 = degreesToRadians(location2.lng);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a =
        pow(sin(dLat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  static double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}

void main() {
  Location pickupLocation = const Location(id: 'pickup', lat: 23.0, lng: 86.5);
  Location dropoffLocation =
      const Location(id: 'dropoff', lat: 24.0, lng: 86.0);

  Location nearestPickupShop = LocationUtils.findNearestShop(pickupLocation);
  Location nearestDropoffShop = LocationUtils.findNearestShop(dropoffLocation);

  print('Nearest shop to pickup location: ${nearestPickupShop.id}');
  print('Nearest shop to dropoff location: ${nearestDropoffShop.id}');
}
