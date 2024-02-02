import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final TabController controller;
  const TabBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: TabBar(
        controller: controller,
        labelColor: Colors.white,
        padding: const EdgeInsets.all(8),
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xfff35556)),
        tabs: const [
          SizedBox(
            width: 120,
            child: Center(child: Text('Upcoming')),
          ),
          SizedBox(
            width: 120,
            child: Center(
              child: Text('Completed'),
            ),
          )
        ],
      ),
    );
  }
}
