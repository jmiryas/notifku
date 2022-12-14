import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import '../constants/constants.dart';
import '../widgets/card_widget.dart';
import '../models/earthquake_model.dart';
import '../widgets/container_background_widget.dart';
import '../widgets/custom_alert_dialog_widget.dart';

class EarthquakeScreen extends StatefulWidget {
  const EarthquakeScreen({Key? key}) : super(key: key);

  @override
  State<EarthquakeScreen> createState() => _EarthquakeScreenState();
}

class _EarthquakeScreenState extends State<EarthquakeScreen> {
  late Future<EarthquakeModel> currentEarthquake;

  Future<EarthquakeModel> fetchLatestEarthquake() async {
    final response = await http.get(Uri.parse(gempaTerbaruAPI));

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
          ContainerBackgroundWidget(
            height: height,
            color: containerBackgroundColor,
          ),
          CardWidget(
            height: height,
            width: width,
            widget: FutureBuilder<EarthquakeModel>(
              future: currentEarthquake,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: ((context) {
                          return CustomAlertDialogWidget(
                            title: "Informasi Gempa",
                            earthquake: snapshot.data!,
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
                                  "$shakeMapAPI${snapshot.data!.shakemap}",
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
                            color: Color(containerBackgroundColor),
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
                                    "Gempa Terbaru",
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
