import 'package:flutter/material.dart';

import '../models/earthquake_model.dart';
import '../widgets/earthquakes_grid_item.dart';

class EarthquakesGridWidget extends StatelessWidget {
  final List<EarthquakeModel> earthquakes;

  const EarthquakesGridWidget({
    super.key,
    required this.earthquakes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: earthquakes.map((item) {
        var magnitude = double.parse(item.magnitude);

        bool isMagnitudeMoreThan5 = magnitude >= 7.0;

        return EarthquakesGridItem(
          earthquake: item,
          magnitude: magnitude,
          isMagnitudeMoreThan5: isMagnitudeMoreThan5,
        );
      }).toList(),
    );
  }
}
