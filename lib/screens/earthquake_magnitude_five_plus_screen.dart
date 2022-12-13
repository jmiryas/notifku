import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notifku/constants/constants.dart';
import 'package:notifku/models/earthquake_model.dart';

class EarthquakeMagnitudeFivePlusScreen extends StatefulWidget {
  const EarthquakeMagnitudeFivePlusScreen({super.key});

  @override
  State<EarthquakeMagnitudeFivePlusScreen> createState() =>
      _EarthquakeMagnitudeFivePlusScreenState();
}

class _EarthquakeMagnitudeFivePlusScreenState
    extends State<EarthquakeMagnitudeFivePlusScreen> {
  late Future<List<EarthquakeModel>> currentEarthquakes;

  Future<List<EarthquakeModel>> fetchLatestEarthquakes() async {
    final response = await http.get(
        Uri.parse("https://data.bmkg.go.id/DataMKG/TEWS/gempaterkini.json"));

    if (response.statusCode == 200) {
      var earthquakesJson = jsonDecode(response.body)["Infogempa"]["gempa"];

      List<EarthquakeModel> earthquakesResult = [];

      earthquakesJson.forEach((item) {
        earthquakesResult.add(EarthquakeModel.fromJson(item));
      });

      return earthquakesResult;
    } else {
      throw Exception('Failed to load earthquake');
    }
  }

  @override
  void initState() {
    super.initState();

    currentEarthquakes = fetchLatestEarthquakes();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double height = MediaQuery.of(context).size.height - statusBarHeight;

    return Scaffold(
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
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
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
            child: Column(
              children: [
                Container(
                  width: width,
                  height: 0.7 * height,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100.withOpacity(0.9),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  child: FutureBuilder(
                    future: currentEarthquakes,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                          padding: const EdgeInsets.all(10.0),
                          children: snapshot.data!.map((item) {
                            var magnitude = double.parse(item.magnitude);

                            bool isMagnitudeMoreThan5 = magnitude >= 7.0;

                            return Card(
                              color: Color(
                                getEarthquakeColor(magnitude),
                              ),
                              child: ListTile(
                                title: Text(
                                  "Gempa Magnitude ${item.magnitude}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: isMagnitudeMoreThan5
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  "${item.tanggal}, ${item.jam}",
                                  style: TextStyle(
                                    color: isMagnitudeMoreThan5
                                        ? Colors.white.withOpacity(0.7)
                                        : Colors.black,
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.info,
                                    color: isMagnitudeMoreThan5
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return const Center(
                          child: SizedBox(
                            width: 25.0,
                            height: 25.0,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    }),
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
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Center(
                    child: SizedBox(
                      width: width,
                      height: 0.4 * (0.1 * height),
                      child: Center(
                        child: Text(
                          "Gempa Magnitude 5+",
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
