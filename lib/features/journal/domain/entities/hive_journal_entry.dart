import 'package:hive/hive.dart';

part 'hive_journal_entry.g.dart';

@HiveType(typeId: 0)
class HiveJournalEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String mood;

  @HiveField(3)
  final String content;

  @HiveField(4)
  final DateTime date;

  HiveJournalEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.mood,
  });
}
