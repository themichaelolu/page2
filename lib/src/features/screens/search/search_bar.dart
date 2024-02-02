import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page2/src/core/models/list_model.dart';
import 'package:page2/src/core/providers/providers.dart';
import 'package:page2/src/features/widgets/search_field.dart';

import '../../widgets/tab_widget.dart';
import '../../widgets/tab_bar_two.dart';
import '../../widgets/tab_bat_one.dart';

class SearchBarScreen extends ConsumerStatefulWidget {
  const SearchBarScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchBarScreen> createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends ConsumerState<SearchBarScreen>
    with SingleTickerProviderStateMixin {
  final List<String> categories = [
    'All',
    'Nearby',
    'Mid-Level',
    'Day',
  ];

  List<Doctor> filteredDoctors = [];
  static List<Doctor> allDoctors = Doctor.doctors;

  List<String> selectedFilters = [];
  bool showFilterChips = false;
  late TabController tabController;

  @override
  void initState() {
    filteredDoctors = allDoctors;
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var darkMode = ref.watch(darkModeProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Switch(
                  value: darkMode,
                  onChanged: (value) {
                    ref.read(darkModeProvider.notifier).toggle();
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SearchField(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showFilterChips = !showFilterChips;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: const Icon(
                        Icons.sort,
                        color: Color(0xfff35556),
                      ),
                    ),
                  )
                ],
              ),
              if (showFilterChips)
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: categories
                        .map((category) => FilterChip(
                              showCheckmark: false,
                              selectedColor: const Color(0xfff35556),
                              selected: selectedFilters.contains(category),
                              side: const BorderSide(
                                color: Color(0xfff35556),
                              ),
                              label: Text(
                                category,
                              ),
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: selectedFilters.isNotEmpty
                                      ? const Color(0xfff35556)
                                      : Colors.white),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedFilters.add(category);
                                  } else {
                                    selectedFilters.remove(category);
                                  }

                                  if (selectedFilters.isEmpty) {
                                    // If no filters are selected, show all doctors
                                    filteredDoctors = allDoctors;
                                  } else {
                                    // Filter doctors based on the selected filters
                                    filteredDoctors = allDoctors.where(
                                      (element) {
                                        return selectedFilters.every(
                                          (filter) {
                                            if (filter == 'All') {
                                              return true; // Show all doctors
                                            } else if (filter == 'Nearby') {
                                              return element.isNearby;
                                            } else if (filter == 'Mid-Level') {
                                              return element.isMidLevel;
                                            } else if (filter == 'Day') {
                                              return element.isDay;
                                            }
                                            return false;
                                          },
                                        );
                                      },
                                    ).toList();
                                  }
                                });
                              },
                            ))
                        .toList(),
                  ),
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView.builder(
                  itemCount: filteredDoctors.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(filteredDoctors[index].doctorName),
                      trailing: filteredDoctors[index].isNearby
                          ? const Text('Nearby')
                          : const Text('Not Nearby'),
                    );
                  },
                ),
              ),
              TabBarWidget(
                controller: tabController,
              ),
              Expanded(
                child: TabBarView(controller: tabController, children: const [
                  TabBarOne(),
                  TabBarTwo(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
