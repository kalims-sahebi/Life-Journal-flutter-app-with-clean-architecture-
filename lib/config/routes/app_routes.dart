import 'package:flutter/material.dart';
import 'package:myproject/features/journal/presentation/screens/add_entry_screen.dart';
import 'package:myproject/features/journal/presentation/screens/home_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String addEntry = '/add-entry'; // ✅ define the route

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    addEntry: (context) => const AddEntryScreen(), // Uncomment when ready
    // settings: (context) => const SettingsScreen(), // Uncomment when ready
  };
}
