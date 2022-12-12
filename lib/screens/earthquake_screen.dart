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
              top: 0.09 * height,
            ),
            // color: Colors.orange,
            width: width,
            height: 0.1 * height,
            child: Center(
              child: Text(
                "Gempa Terbaru",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 0.065 * height,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontFamily: "Lora-Regular",
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 0.20 * height,
            ),
            width: width,
            height: 0.70 * height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: const Offset(
                    0.5,
                    1.0,
                  ),
                ),
              ],
            ),
            child: FutureBuilder<EarthquakeModel>(
              future: currentEarthquake,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EarthquakeDetailScreen(
                            earthquake: snapshot.data!,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: width,
                          height: 0.60 * height,
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100.withOpacity(0.9),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
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
                        const SizedBox(
                          height: 5.0,
                        ),
                        SizedBox(
                          width: width,
                          height: 0.05 * height,
                          // color: Colors.yellow,
                          child: Center(
                            child: Text(
                              "Gempa Magnitude ${snapshot.data!.magnitude}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 0.04 * height,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width,
                          height: 0.04 * height,
                          // color: Colors.orange,
                          child: Center(
                            child: Text(
                              "${snapshot.data!.tanggal}, ${snapshot.data!.jam}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 0.025 * height,
                                letterSpacing: 1.0,
                              ),
                            ),
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
