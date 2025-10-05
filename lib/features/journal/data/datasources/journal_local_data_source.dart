import 'package:hive/hive.dart';
import '../../domain/entities/hive_journal_entry.dart';

class JournalLocalDataSource {
  final Box<HiveJournalEntry> _box = Hive.box('journalBox');

  Future<void> addEntry(HiveJournalEntry entry) async {
    await _box.put(entry.id, entry);
  }

  List<HiveJournalEntry> getAllEntries() {
    return _box.values.toList();
  }

  Future<void> deleteEntry(String id) async {
    await _box.delete(id);
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
