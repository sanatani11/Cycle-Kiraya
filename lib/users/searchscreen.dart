import 'package:cycle_kiraya/providers/datahandling.dart';
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
  TextEditingController _pickupLocationTextController = TextEditingController();
  TextEditingController _dropOffLocationTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    String place = Provider.of<DataHandling>(context).pickupLocation != null
        ? Provider.of<DataHandling>(context).pickupLocation!.placeName
        : "";
    _pickupLocationTextController.text = place;
    return Scaffold(
      body: Column(
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
          )
        ],
      ),
    );
  }
}
