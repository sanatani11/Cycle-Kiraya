import 'package:cycle_kiraya/models/address.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoutingScreen extends StatefulWidget {
  final List<Address> addresses;
  const RoutingScreen({super.key, required this.addresses});
  @override
  State<RoutingScreen> createState() {
    return _RoutingScreenState();
  }
}

class _RoutingScreenState extends State<RoutingScreen> {
  GoogleMapController? _googleMapController;
  Position? currentPostion;
  int currentAddressIndex = 0;
  @override
  void initState() {
    super.initState();

    getCurrentPosition();
  }

  Future<void> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPostion = position;
    });
  }

  Set<Marker> createMarkers() {
    return widget.addresses.map((address) {
      return Marker(
        markerId: MarkerId(address.placeId),
        position: LatLng(address.lat, address.lng),
        infoWindow: InfoWindow(
          title: address.placeName,
          snippet: address.placeFormattedAddress,
        ),
      );
    }).toSet();
  }

  void moveCameraToAddress(Address address) async {
    final newPosition = CameraPosition(
      target: LatLng(address.lat, address.lng),
      zoom: 15,
    );
    await _googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(currentPostion!.latitude, currentPostion!.longitude),
        zoom: 15,
      ),
      onMapCreated: (controller) => _googleMapController = controller,
      markers: createMarkers(),
    );
  }

  void moveToPreviousAddress() {
    if (currentAddressIndex > 0) {
      setState(() {
        currentAddressIndex--;
      });
      moveCameraToAddress(widget.addresses[currentAddressIndex]);
    }
  }

  void moveToNextAddress() {
    if (currentAddressIndex < widget.addresses.length - 1) {
      setState(() {
        currentAddressIndex++;
      });
      moveCameraToAddress(widget.addresses[currentAddressIndex]);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildMap(),
          Positioned(
            bottom: 20,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left),
                  onPressed: moveToPreviousAddress,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_right),
                  onPressed: moveToNextAddress,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
