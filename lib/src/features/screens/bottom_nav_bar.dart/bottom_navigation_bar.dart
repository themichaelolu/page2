import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:page2/src/features/screens/page_two/page2.dart';
import 'package:page2/src/features/screens/search/search_bar.dart';

import '../../widgets/bottom_nav_bar_widget.dart';
import '../../../../main.dart';
import '../page_one/page_one.dart';
import '../appointment/newpage.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    Appointment(),
    PageOne(),
    PageTwo(),
    SearchBarScreen(),
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
      bottomNavigationBar: BottomNavBarWidget(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
