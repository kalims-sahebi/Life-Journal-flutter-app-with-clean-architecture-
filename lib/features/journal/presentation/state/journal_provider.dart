import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:myproject/features/journal/domain/entities/hive_journal_entry.dart';
import 'package:myproject/features/journal/domain/entities/journal_entry.dart';

class JournalNotifier extends StateNotifier<List<JournalEntry>> {
  late Box<HiveJournalEntry> _box;

  JournalNotifier() : super([]) {
    _init();
  }

  // Initialize Hive box and load existing entries
  Future<void> _init() async {
    _box = Hive.box<HiveJournalEntry>('journalBox');
    state =
        _box.values
            .map(
              (hiveEntry) => JournalEntry(
                mood: hiveEntry.mood,
                id: hiveEntry.id,
                title: hiveEntry.title,
                content: hiveEntry.content,
                date: hiveEntry.date,
              ),
            )
            .toList();
  }

  // Add a new entry
  void addEntry(JournalEntry entry) {
    // 1️⃣ Update state
    state = [...state, entry];

    // 2️⃣ Save to Hive
    final hiveEntry = HiveJournalEntry(
      id: entry.id,
      mood: entry.mood,
      title: entry.title,
      content: entry.content,
      date: entry.date,
    );
    _box.put(hiveEntry.id, hiveEntry);
  }

  // Remove an entry by index
  void removeEntry(int index) {
    final temp = List<JournalEntry>.from(state);
    final removed = temp.removeAt(index);
    state = temp;

    // Remove from Hive
    _box.delete(removed.id);
  }

  // Update an existing entry
  void updateEntry(int index, JournalEntry updatedEntry) {
    final temp = List<JournalEntry>.from(state);
    temp[index] = updatedEntry;
    state = temp;

    // Update Hive
    final hiveEntry = HiveJournalEntry(
      id: updatedEntry.id,
      mood: updatedEntry.mood,
      title: updatedEntry.title,
      content: updatedEntry.content,
      date: updatedEntry.date,
    );
    _box.put(hiveEntry.id, hiveEntry);
  }

  // Optional: clear all entries
  void clearAll() {
    state = [];
    _box.clear();
  }
}

// Provider remains the same
final journalProvider =
    StateNotifierProvider<JournalNotifier, List<JournalEntry>>(
      (ref) => JournalNotifier(),
    );
