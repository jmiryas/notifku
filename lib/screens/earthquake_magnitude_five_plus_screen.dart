import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../widgets/card_widget.dart';
import '../models/earthquake_model.dart';
import '../widgets/card_item_child_widget.dart';
import '../widgets/earthquakes_grid_widget.dart';
import '../widgets/card_item_child_text_widget.dart';
import '../widgets/container_background_widget.dart';

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
    final response = await http.get(Uri.parse(gempaMagnitude5Plus));

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
          ContainerBackgroundWidget(
            height: height,
            color: containerBackgroundColor,
          ),
          CardWidget(
            height: height,
            width: width,
            widget: Column(
              children: [
                CardItemChildWidget(
                  width: width,
                  height: 0.7 * height,
                  color: Colors.grey.shade100.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  widget: FutureBuilder(
                    future: currentEarthquakes,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return EarthquakesGridWidget(
                          earthquakes: snapshot.data!,
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
                CardItemChildWidget(
                  width: width,
                  height: 0.1 * height,
                  color: const Color(containerBackgroundColor),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  widget: CardItemChildTextWidget(
                    width: width,
                    height: 0.4 * (0.1 * height),
                    label: "Gempa Magnitude 5+",
                    fontSize: 0.7 * (0.4 * (0.1 * height)),
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
