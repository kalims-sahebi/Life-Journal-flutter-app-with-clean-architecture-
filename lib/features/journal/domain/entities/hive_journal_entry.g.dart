// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_journal_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveJournalEntryAdapter extends TypeAdapter<HiveJournalEntry> {
  @override
  final int typeId = 0;

  @override
  HiveJournalEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveJournalEntry(
      id: fields[0] as String,
      mood: fields[0] as String,
      title: fields[1] as String,
      content: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveJournalEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveJournalEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
