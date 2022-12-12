import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../constants/constants.dart';
import '../models/earthquake_model.dart';

class EarthquakeDetailScreen extends StatelessWidget {
  final EarthquakeModel earthquake;

  const EarthquakeDetailScreen({
    super.key,
    required this.earthquake,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double height = MediaQuery.of(context).size.height - statusBarHeight;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 236, 243),
      body: Container(
        width: width,
        height: height,
        margin: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width,
              height: 0.8 * height,
              padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Hero(
                  tag: earthquake.tanggal,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: "$ShakeMapAPI${earthquake.shakemap}",
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        width: 25.0,
                        height: 25.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.image),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: width,
              height: 0.08 * height,
              margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF227093),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        // color: Colors.red,
                        child: const Center(
                          child: Text(
                            "Kembali",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: GestureDetector(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Gempa Magnitude ${earthquake.magnitude}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "${earthquake.tanggal}, ${earthquake.jam}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        earthquake.wilayah,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Kedalaman: ${earthquake.kedalaman}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Dirasakan: ${earthquake.dirasakan}",
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
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF227093),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        // color: Colors.red,
                        child: const Center(
                          child: Text(
                            "Tampilkan Informasi",
                            style: TextStyle(
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
      ),
    );
  }
}
