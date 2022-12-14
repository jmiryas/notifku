import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/card_widget.dart';
import '../widgets/card_item_child_widget.dart';
import '../widgets/card_item_child_text_widget.dart';
import '../widgets/container_background_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    double height = MediaQuery.of(context).size.height - statusBarHeight;

    return Scaffold(
      backgroundColor: scaffoldBgColor,
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
                  widget: ListView(
                    children: [
                      const ListTile(
                        title: Text("Tentang Aplikasi"),
                        subtitle: Text(
                          "Aplikasi ini dibuat dengan menggunakan Flutter untuk menampilkan informasi mengenai gempa terbaru dan gempa dengan magnitude 5+.",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const ListTile(
                        title: Text("Author"),
                        subtitle: Text(
                          "Rizky Ramadhan",
                        ),
                      ),
                      const ListTile(
                        title: Text("Sumber Data"),
                        subtitle: Text(
                          "Data yang digunakan aplikasi ini berasal dari website Data Terbuka BMKG (https://data.bmkg.go.id/).",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        width: 0.45 * width,
                        height: 0.45 * width,
                        child: Image.asset(
                          "assets/images/bmkg.png",
                        ),
                      ),
                    ],
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
                    label: "Tentang Kami",
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
