import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myproject/features/journal/domain/entities/journal_entry.dart';

// StateNotifier: manages a list of entries
class JournalNotifier extends StateNotifier<List<JournalEntry>> {
  JournalNotifier() : super([]);

  void addEntry(JournalEntry entry) {
    state = [...state, entry]; // simply add the full entity
  }

  void removeEntry(int index) {
    final temp = List<JournalEntry>.from(state);
    temp.removeAt(index);
    state = temp;
  }

  void updateEntry(int index, JournalEntry updatedEntry) {
    final temp = List<JournalEntry>.from(state);
    temp[index] = updatedEntry;
    state = temp;
  }
}

// The StateNotifierProvider exposes the state and logic
final journalProvider =
    StateNotifierProvider<JournalNotifier, List<JournalEntry>>(
      (ref) => JournalNotifier(),
    );
