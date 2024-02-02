import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page2/src/core/providers/providers.dart';

class BottomNavBarWidget extends ConsumerStatefulWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  ConsumerState<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends ConsumerState<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    var darkMode = ref.watch(darkModeProvider);
    return BottomNavigationBar(
      selectedItemColor: const Color(0xfff35556),
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: darkMode ? Colors.grey : Colors.black,
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Appointment',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Certifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
      ],
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
    );
  }
}
