import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardShakemapWidget extends StatelessWidget {
  final double width;
  final double height;
  final String shakemapUrl;

  const CardShakemapWidget({
    super.key,
    required this.width,
    required this.height,
    required this.shakemapUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 0.7 * height,
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
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
          imageUrl: shakemapUrl,
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
    );
  }
}
