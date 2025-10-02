// feature/journal/domain/entities/journal_entry.dart
class JournalEntry {
  final String title;
  final String content;
  final DateTime date;
  final String mood;

  JournalEntry({
    required this.title,
    required this.content,
    required this.date,
    required this.mood,
  });
}
