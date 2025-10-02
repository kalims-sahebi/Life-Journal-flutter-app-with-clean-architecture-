import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myproject/features/journal/domain/entities/journal_entry.dart';
import '../state/journal_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddEntryScreen extends ConsumerStatefulWidget {
  const AddEntryScreen({super.key});

  @override
  ConsumerState<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends ConsumerState<AddEntryScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedMood = 'Neutral';
  File? _pickedImage;

  final _moods = ['Happy', 'Sad', 'Neutral', 'Excited'];

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: now,
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _pickedImage = File(pickedFile.path));
    }
  }

  void _saveEntry() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title, content, and date are required!')),
      );
      return;
    }

    // ✅ Create the entity
    final newEntry = JournalEntry(
      title: title,
      content: content,
      date: _selectedDate!,
      mood: _selectedMood,
    );

    // ✅ Add to provider
    ref.read(journalProvider.notifier).addEntry(newEntry);

    Navigator.pop(context); // go back to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Journal Entry")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Content"),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date chosen'
                        : 'Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                  ),
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text("Choose Date"),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: const Text('Select Mood'),
                value: _selectedMood,
                items:
                    _moods
                        .map(
                          (m) => DropdownMenuItem<String>(
                            value: m,
                            child: Text(m, overflow: TextOverflow.ellipsis),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedMood = value);
                },
              ),
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                _pickedImage == null
                    ? const Text("No image selected")
                    : Image.file(_pickedImage!, width: 80, height: 80),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: _pickImage,
                  child: const Text("Pick Image"),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveEntry,
              child: const Text("Save Entry"),
            ),
          ],
        ),
      ),
    );
  }
}
