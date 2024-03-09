import 'package:cycle_kiraya/assistant/request.dart';
import 'package:cycle_kiraya/models/address.dart';
import 'package:cycle_kiraya/models/place_predications.dart';
import 'package:cycle_kiraya/providers/datahandling.dart';
import 'package:cycle_kiraya/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _pickupLocationTextController =
      TextEditingController();
  final TextEditingController _dropOffLocationTextController =
      TextEditingController();
  List<PlacePredictions> placesPredictionList = [];

  @override
  Widget build(BuildContext context) {
    String place = Provider.of<DataHandling>(context).pickupLocation != null
        ? Provider.of<DataHandling>(context).pickupLocation!.placeName
        : "";
    _pickupLocationTextController.text = place;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 215,
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.black,
                    offset: Offset(0.7, 0.7),
                    spreadRadius: 0.6)
              ]),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        ),
                        const Center(
                          child: Text(
                            "Set Drop of",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.my_location,
                          color: Color.fromARGB(255, 228, 114, 152),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: TextField(
                              controller: _pickupLocationTextController,
                              decoration: InputDecoration(
                                hintText: "pickup Location",
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 11, right: 11),
                                fillColor: Colors.grey.shade300,
                                isDense: true,
                                filled: true,
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 18.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 228, 114, 152),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: TextField(
                              onChanged: (value) {
                                predictPlaces(value);
                              },
                              controller: _dropOffLocationTextController,
                              decoration: InputDecoration(
                                hintText: "Where to?",
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 11, right: 11),
                                fillColor: Colors.grey.shade300,
                                isDense: true,
                                filled: true,
                              ),
                            ),
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ),
            (placesPredictionList.isNotEmpty)
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListView.separated(
                      itemBuilder: (context, index) => PredictionTile(
                          placePredictions: placesPredictionList[index]),
                      separatorBuilder: (BuildContext context, int index) =>
                          const DividerWidget(),
                      itemCount: placesPredictionList.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void predictPlaces(String placename) async {
    if (placename.isNotEmpty) {
      String autoCompleteUrl =
          "https://api.geoapify.com/v1/geocode/autocomplete?text=$placename&filter=countrycode:in&format=json&apiKey=03298a44ba394f6784de323e34b18bb8";

      var res = await RequestAssistant.getAddress(autoCompleteUrl);
      if (res == "failed") return;
      //print(res);

      var predictions = res["results"];
      var placeList = (predictions as List)
          .map((e) => PlacePredictions.fromJson(e))
          .toList();

      setState(() {
        placesPredictionList = placeList;
      });
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;
  PredictionTile({super.key, required this.placePredictions});

  @override
  Widget build(BuildContext context) {
    void getPlaceAddress(String placeId) async {
      showDialog(
        context: context,
        builder: (context) => const Dialog(
          child: Text("wait, setting..."),
        ),
      );
      String placeDetailsUrl =
          "https://api.geoapify.com/v2/place-details?id=$placeId&apiKey=03298a44ba394f6784de323e34b18bb8";
      var res = await RequestAssistant.getAddress(placeDetailsUrl);

      Navigator.of(context).pop();
      if (res == "failed") return;

      Address address = Address(
          placeFormattedAddress: res["features"][0]["properties"]["formatted"],
          placeId: placeId,
          placeName: res["features"][0]["properties"]["name"],
          lat: res["features"][0]["properties"]["lat"],
          lng: res["features"][0]["properties"]["lon"]);
      Provider.of<DataHandling>(context, listen: false)
          .updateDropoffLocationAddress(address);
      Navigator.pop(context, "address-returned");
    }

    return InkWell(
      onTap: () {
        getPlaceAddress(placePredictions.placeId);
      },
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(Icons.add_location),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placePredictions.mainText,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        placePredictions.secondaryText,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
