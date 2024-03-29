import 'dart:async';
import 'package:cycle_kiraya/assistant/assistantmethod.dart';
import 'package:cycle_kiraya/models/address.dart';
import 'package:cycle_kiraya/models/location.dart';
import 'package:cycle_kiraya/providers/datahandling.dart';
import 'package:cycle_kiraya/users/routing.dart';
import 'package:cycle_kiraya/users/searchscreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cycle_kiraya/widgets/divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:location/location.dart';
import 'package:cycle_kiraya/data/locations.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  static String idScreen = "dashboard";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //LocationData? currentLocation;

  double bottomPadding = 0.0;
  Position? currentLocation;
  void getCurrentLocation() async {
    //Location location = Location();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      currentLocation = position;
    });
    print(position);

    //LocationData? locationData = await location.getLocation();
    LatLng latLngPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);
    _googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethod.searchCoordinatesAddress(
        currentLocation!, context);
    //print("This is my address:  " + address);
  }

  // @override
  // void initState() {
  //   getCurrentLocation();
  //   super.initState();
  // }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  GoogleMapController? _googleMapController;

  static const _initalCameraPostion =
      CameraPosition(target: LatLng(36.25, -120.23), zoom: 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      drawer: Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165,
                child: const DrawerHeader(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Profile Name',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'visit profile',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )),
              ),
              const DividerWidget(),
              const SizedBox(
                height: 12.0,
              ),
              const ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  'History',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'visit profile',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  'About',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPadding),
            initialCameraPosition: _initalCameraPostion,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            markers: {
              for (final location in availableLocation)
                Marker(
                  markerId: MarkerId(location.id),
                  position: LatLng(location.lat, location.lng),
                ),
            },
            onMapCreated: (controller) {
              _controller.complete(controller);
              _googleMapController = controller;
              getCurrentLocation();
              setState(() {
                bottomPadding = 350;
              });
            },
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 350.0,
              //color: Colors.yellowAccent,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      spreadRadius: 0.5,
                      blurRadius: 10,
                      offset: Offset(0.5, 0.5))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Hellooo',
                      style: TextStyle(fontSize: 15),
                    ),
                    const Text(
                      'Where to?',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var res = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 0.5,
                                blurRadius: 10,
                                offset: Offset(0.5, 0.5))
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Search Drop off',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Provider.of<DataHandling>(context).pickupLocation !=
                                    null
                                ? Text(LocationUtils.findNearestShop(Location(
                                        id: "pickup",
                                        lat: Provider.of<DataHandling>(context)
                                            .pickupLocation!
                                            .lat,
                                        lng: Provider.of<DataHandling>(context)
                                            .pickupLocation!
                                            .lng))
                                    .id)
                                : const Text("Add the picking address"),
                            const SizedBox(
                              height: 4.0,
                            ),
                            const Text(
                              "This will be the pickup shop",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12.0),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DividerWidget(),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.work,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Provider.of<DataHandling>(context)
                                        .dropoffLocation !=
                                    null
                                ? Text(LocationUtils.findNearestShop(Location(
                                        id: "pickup",
                                        lat: Provider.of<DataHandling>(context)
                                            .dropoffLocation!
                                            .lat,
                                        lng: Provider.of<DataHandling>(context)
                                            .dropoffLocation!
                                            .lng))
                                    .id)
                                : const Text("Add the picking address"),
                            const SizedBox(
                              height: 4.0,
                            ),
                            const Text(
                              "Address where you work.",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12.0),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (Provider.of<DataHandling>(context).dropoffLocation !=
                            null &&
                        Provider.of<DataHandling>(context).pickupLocation !=
                            null)
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RoutingScreen(addresses: [
                                      Provider.of<DataHandling>(context)
                                          .pickupLocation!,
                                      Provider.of<DataHandling>(context)
                                          .dropoffLocation!
                                    ])));
                          },
                          child: const Text("Move"),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
