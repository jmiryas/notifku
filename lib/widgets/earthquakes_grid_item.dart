import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/earthquake_model.dart';
import '../widgets/custom_alert_dialog_widget.dart';

class EarthquakesGridItem extends StatelessWidget {
  final EarthquakeModel earthquake;
  final double magnitude;
  final bool isMagnitudeMoreThan5;

  const EarthquakesGridItem({
    super.key,
    required this.earthquake,
    required this.magnitude,
    required this.isMagnitudeMoreThan5,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(
        getEarthquakeColor(magnitude),
      ),
      child: ListTile(
        title: Text(
          "Gempa Magnitude $magnitude",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isMagnitudeMoreThan5 ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          "${earthquake.tanggal}, ${earthquake.jam}",
          style: TextStyle(
            color: isMagnitudeMoreThan5
                ? Colors.white.withOpacity(0.7)
                : Colors.black,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: ((context) {
                return CustomAlertDialogWidget(
                    title: "Informasi Gempa", earthquake: earthquake);
              }),
            );
          },
          icon: Icon(
            Icons.info,
            color: isMagnitudeMoreThan5 ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
