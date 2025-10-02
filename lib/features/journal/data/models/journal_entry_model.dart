// feature/journal/data/models/journal_entry_model.dart
import '../../domain/entities/journal_entry.dart';

class JournalEntryModel extends JournalEntry {
  JournalEntryModel({
    required super.title,
    required super.content,
    required super.date,
    required super.mood,
  });

  factory JournalEntryModel.fromJson(Map<String, dynamic> json) {
    return JournalEntryModel(
      title: json['title'],
      content: json['content'],
      date: DateTime.parse(json['date']),
      mood: json['mood'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'mood': mood,
    };
  }
}
