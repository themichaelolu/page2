import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page2/src/features/screens/bottom_nav_bar.dart/bottom_navigation_bar.dart';
import 'package:page2/src/core/providers/providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var darkModeNotifier = ref.watch(darkModeProvider);
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: const NavBarWidget(),
        darkTheme: ThemeData.dark(),
        themeMode: darkModeNotifier ? ThemeMode.dark : ThemeMode.light,
      ),
    );
  }
}
