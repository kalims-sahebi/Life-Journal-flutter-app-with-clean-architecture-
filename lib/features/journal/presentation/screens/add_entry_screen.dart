import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myproject/features/journal/domain/entities/journal_entry.dart';
import 'package:uuid/uuid.dart';
import '../state/journal_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

final uuid = Uuid(); // create a Uuid instance

class AddEntryScreen extends ConsumerStatefulWidget {
  const AddEntryScreen({super.key});

  @override
  ConsumerState<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends ConsumerState<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedMood = 'Neutral';
  File? _pickedImage;
  Position? _pickedLocation;

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

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location services are disabled.")),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permissions are denied.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permanently denied.")),
      );
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() => _pickedLocation = position);
  }

  void _saveEntry() {
    if (!_formKey.currentState!.validate() || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix errors before saving.')),
      );
      return;
    }

    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    final newId = uuid.v4(); // generate a new unique id

    final newEntry = JournalEntry(
      id: newId,
      title: title,
      content: content,
      date: _selectedDate!,
      mood: _selectedMood,
      // later we extend JournalEntry to support location + image if needed
    );

    ref.read(journalProvider.notifier).addEntry(newEntry);

    Navigator.pop(context); // go back
  }

  @override
  Widget build(BuildContext context) {
    final isFormValid =
        _titleController.text.trim().isNotEmpty &&
        _contentController.text.trim().isNotEmpty &&
        _selectedDate != null;

    return Scaffold(
      appBar: AppBar(title: const Text("Add Journal Entry")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title
              TextFormField(
                controller: _titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title is required.";
                  }
                  if (value.trim().length < 3) {
                    return "Title must be at least 3 characters.";
                  }
                  return null;
                },
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),

              // Content
              TextFormField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Content is required.";
                  }
                  if (value.trim().length < 10) {
                    return "Content must be at least 10 characters.";
                  }
                  return null;
                },
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 12),

              // Date picker
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

              // Mood dropdown
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
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

              // Image picker
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
              const SizedBox(height: 12),

              // Location picker
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _pickedLocation == null
                          ? "No location selected"
                          : "Location: ${_pickedLocation!.latitude.toStringAsFixed(4)}, ${_pickedLocation!.longitude.toStringAsFixed(4)}",
                    ),
                  ),
                  TextButton(
                    onPressed: _getCurrentLocation,
                    child: const Text("Get Location"),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Save button
              ElevatedButton(
                onPressed: isFormValid ? _saveEntry : null,
                child: const Text("Save Entry"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
