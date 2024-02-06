import 'dart:async';

import 'package:cycle_kiraya/widgets/divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cycle_kiraya/data/locations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();
    LocationData? locationData = await location.getLocation();
    if (locationData != null) {
      setState(() {
        currentLocation = locationData;
      });
    } else {
      print('kuchh nahi mila yaar');
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

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
      body: Stack(
        children: [
          currentLocation == null
              ? const Center(
                  child: Text('Loading.'),
                )
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    zoom: 15,
                  ),
                  markers: {
                    for (final location in availableLocation)
                      Marker(
                        markerId: MarkerId(location.id),
                        position: LatLng(location.lat, location.lng),
                      ),
                  },
                  onMapCreated: (controller) {
                    _controller.complete(controller);
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
                    Container(
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
                    const SizedBox(
                      height: 24,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Home',
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Address where you live.",
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
                    const Row(
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add Work',
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Address where you work.",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12.0),
                            ),
                          ],
                        )
                      ],
                    )
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
