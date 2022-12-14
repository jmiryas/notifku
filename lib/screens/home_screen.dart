import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';

import '../constants/constants.dart';
import '../screens/about_us_screen.dart';
import '../screens/earthquake_screen.dart';
import '../screens/earthquake_magnitude_five_plus_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    EarthquakeScreen(),
    EarthquakeMagnitudeFivePlusScreen(),
    AboutUsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Typicons.waves),
            label: "Gempa Terbaru",
            backgroundColor: Color(0xFF227093),
          ),
          BottomNavigationBarItem(
            icon: Icon(Typicons.waves),
            label: "Gempa M. 5+",
            backgroundColor: Color(0xFF227093),
          ),
          BottomNavigationBarItem(
            icon: Icon(Typicons.info),
            label: "Tentang Kami",
            backgroundColor: Color(0xFF227093),
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: unselectedItemColor,
        backgroundColor: const Color(containerBackgroundColor),
      ),
    );
  }
}
