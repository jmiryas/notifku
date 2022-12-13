import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import '../constants/constants.dart';
import '../models/earthquake_model.dart';
import '../screens/earthquake_detail_screen.dart';

class EarthquakeScreen extends StatefulWidget {
  const EarthquakeScreen({Key? key}) : super(key: key);

  @override
  State<EarthquakeScreen> createState() => _EarthquakeScreenState();
}

class _EarthquakeScreenState extends State<EarthquakeScreen> {
  late Future<EarthquakeModel> currentEarthquake;

  Future<EarthquakeModel> fetchLatestEarthquake() async {
    final response = await http
        .get(Uri.parse('https://data.bmkg.go.id/DataMKG/TEWS/autogempa.json'));

    if (response.statusCode == 200) {
      return EarthquakeModel.fromJson(
          jsonDecode(response.body)["Infogempa"]["gempa"]);
    } else {
      throw Exception('Failed to load earthquake');
    }
  }

  @override
  void initState() {
    super.initState();

    currentEarthquake = fetchLatestEarthquake();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30.0;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double height = MediaQuery.of(context).size.height - statusBarHeight;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 236, 243),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF227093),
            height: 0.4 * height,
          ),
          Container(
            margin: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 0.1 * height,
            ),
            width: width,
            height: 0.8 * height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              // implement shadow effect
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(3, 3),
                  spreadRadius: 0.1,
                  blurStyle: BlurStyle.normal,
                ),
              ],
            ),
            child: FutureBuilder<EarthquakeModel>(
              future: currentEarthquake,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: const Text(
                              "Informasi Gempa",
                              textAlign: TextAlign.center,
                            ),
                            content: SizedBox(
                              height: 150.0,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Gempa Magnitude ${snapshot.data!.magnitude}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "${snapshot.data!.tanggal}, ${snapshot.data!.jam}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      snapshot.data!.wilayah,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Kedalaman: ${snapshot.data!.kedalaman}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "Dirasakan: ${snapshot.data!.dirasakan}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: width,
                          height: 0.7 * height,
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100.withOpacity(0.9),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl:
                                  "$ShakeMapAPI${snapshot.data!.shakemap}",
                              placeholder: (context, url) => const Center(
                                child: SizedBox(
                                  width: 25.0,
                                  height: 25.0,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(Icons.image),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          height: 0.1 * height,
                          decoration: const BoxDecoration(
                            color: Color(0xFF227093),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: width,
                                height: 0.4 * (0.1 * height),
                                child: Center(
                                  child: Text(
                                    "Gempa Magnitude ${snapshot.data!.magnitude}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                      fontSize: 0.7 * (0.4 * (0.1 * height)),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width,
                                height: 0.3 * (0.1 * height),
                                child: Center(
                                  child: Text(
                                    "${snapshot.data!.tanggal}, ${snapshot.data!.jam}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.0,
                                      fontSize: 0.6 * (0.3 * (0.1 * height)),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Maaf, terjadi error"),
                  );
                }

                return const Center(
                  child: SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
