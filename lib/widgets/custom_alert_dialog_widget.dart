import 'package:flutter/material.dart';
import 'package:notifku/models/earthquake_model.dart';

class CustomAlertDialogWidget extends StatelessWidget {
  final String title;
  final EarthquakeModel earthquake;

  const CustomAlertDialogWidget({
    super.key,
    required this.title,
    required this.earthquake,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
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
  }
}
