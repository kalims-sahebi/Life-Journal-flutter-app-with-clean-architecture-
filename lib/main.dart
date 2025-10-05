import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myproject/features/journal/domain/entities/hive_journal_entry.dart';
import 'app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter(); // 🔥 initializes Hive

  // Register your adapter
  Hive.registerAdapter(HiveJournalEntryAdapter());

  // Open a box (like a local database table)
  await Hive.openBox<HiveJournalEntry>('journalBox'); // 📦 open your first box

  //print('✅ Hive initialized and journalBox opened successfully');
  runApp(const ProviderScope(child: MyApp()));
}
