import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dental_news/home/home_clinic/home_clinic.dart';
import 'package:dental_news/home/home_toothache/home_toothache.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../home/dental_care/home_care.dart';
import '../home/home_screen.dart';
import '../home/support/home_support.dart';

class MainBottom extends StatefulWidget {
  const MainBottom({super.key});

  @override
  State<MainBottom> createState() => _MainBottomState();
}

class _MainBottomState extends State<MainBottom> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(
    
    ),
    const HomeToothache(),
    const HomeCare(),
    const HomeClinic(),
    const HomeSupport(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 50,
        iconSize: 24, // ลดขนาดไอคอนลง
        showElevation: true,
        selectedIndex: _currentIndex,
        shadowColor: Theme.of(context).hoverColor,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(LineIcons.home),
            title: Text(
              tr('app.Home'),
              style: const TextStyle(fontSize: 12), // ลดขนาดข้อความ
            ),
            activeColor: Theme.of(context).hoverColor,
          ),
          BottomNavyBarItem(
            icon: const Icon(LineIcons.tooth),
            title: Text(
              tr('app.toothache'),
              style: const TextStyle(fontSize: 12), // ลดขนาดข้อความ
            ),
            activeColor: Theme.of(context).hoverColor,
          ),
          BottomNavyBarItem(
            icon: const Icon(LineIcons.teeth),
            title: Text(
              tr('app.Care_teeth'),  
              style: const TextStyle(fontSize: 12), // ลดขนาดข้อความ
            ),
            activeColor: Theme.of(context).hoverColor,
          ),
          BottomNavyBarItem(
            icon: const Icon(LineIcons.medicalClinic),
            title: Text(
              tr('app.Clinic'),
              style: const TextStyle(fontSize: 12), // ลดขนาดข้อความ
            ),
            activeColor: Theme.of(context).hoverColor,
          ),
          BottomNavyBarItem(
            icon: const Icon(LineIcons.userCircle),
            title: Text(
              tr('app.Support'),
              style: const TextStyle(fontSize: 12), // ลดขนาดข้อความ
            ),
            activeColor: Theme.of(context).hoverColor,
          ),
        ],
      ),
    );
  }
}
