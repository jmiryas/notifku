import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../screens/home_screen.dart';
import '../constants/constants.dart';
import '../models/earthquake_model.dart';

const gempaTerbaruAPI = "gempaTerbaruAPI";
const prefsEarthquake = "currentEarthquake";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case gempaTerbaruAPI:
        var result = await http.get(Uri.parse(shakeMapAPI));

        var resultJson = json.decode(result.body);

        EarthquakeModel earthquakeResult =
            EarthquakeModel.fromJson(resultJson["Infogempa"]["gempa"]);

        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (!prefs.containsKey(prefsEarthquake) ||
            isNewEarthquake(prefs, earthquakeResult)) {
          FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
              FlutterLocalNotificationsPlugin();

          const AndroidInitializationSettings initializationSettingsAndroid =
              AndroidInitializationSettings('@mipmap/ic_launcher');

          const InitializationSettings initializationSettings =
              InitializationSettings(
            android: initializationSettingsAndroid,
          );
          await flutterLocalNotificationsPlugin
              .initialize(initializationSettings);

          const AndroidNotificationDetails androidNotificationDetails =
              AndroidNotificationDetails(
            'Earthquake-1',
            'Earthquake',
            channelDescription: 'Latest earthquake',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            styleInformation: BigTextStyleInformation(""),
          );

          const NotificationDetails notificationDetails =
              NotificationDetails(android: androidNotificationDetails);

          await flutterLocalNotificationsPlugin.show(
            0,
            "Gempa ${earthquakeResult.magnitude}",
            earthquakeResult.wilayah,
            notificationDetails,
            payload: gempaTerbaruAPI,
          );
        }

        prefs.setString(
          prefsEarthquake,
          jsonEncode(
            earthquakeResult.toJson(),
          ),
        );

        break;
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  await Workmanager().registerPeriodicTask(
    "task-identifier",
    gempaTerbaruAPI,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notifku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

bool isNewEarthquake(SharedPreferences prefs, fetchedEartquake) {
  if (prefs.containsKey("currentEarthquake")) {
    var prefsDateTime = DateTime.parse(
        jsonDecode(prefs.getString("currentEarthquake")!)["DateTime"]);

    var comparationResult = prefsDateTime.isBefore(fetchedEartquake.dateTime!);

    return comparationResult;
  }

  return false;
}
