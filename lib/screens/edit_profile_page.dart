import 'package:flutter/material.dart';

import '../models/student_profile.dart';

/// A form screen for editing the student profile.
///
/// Pushed on top of the profile screen; returns an updated
/// [StudentProfile] when the user taps Save.
class EditProfilePage extends StatefulWidget {
  final StudentProfile profile;

  const EditProfilePage({super.key, required this.profile});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _studentNumberController;
  late final TextEditingController _courseController;
  late final TextEditingController _yearSectionController;
  late final TextEditingController _emailController;
  late final TextEditingController _bioController;
  late final TextEditingController _careerGoalController;
  late final TextEditingController _skillsController;
  late final TextEditingController _programmingLanguagesController;
  late final TextEditingController _hobbiesController;

  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void initState() {
    super.initState();
    final profile = widget.profile;
    _nameController = TextEditingController(text: profile.fullName);
    _studentNumberController =
        TextEditingController(text: profile.studentNumber);
    _courseController = TextEditingController(text: profile.course);
    _yearSectionController =
        TextEditingController(text: profile.yearLevelAndSection);
    _emailController = TextEditingController(text: profile.email);
    _bioController = TextEditingController(text: profile.bio);
    _careerGoalController = TextEditingController(text: profile.careerGoal);
    _skillsController = TextEditingController(text: profile.skills.join(', '));
    _programmingLanguagesController =
        TextEditingController(text: profile.programmingLanguages.join(', '));
    _hobbiesController =
        TextEditingController(text: profile.hobbies.join(', '));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _studentNumberController.dispose();
    _courseController.dispose();
    _yearSectionController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _careerGoalController.dispose();
    _skillsController.dispose();
    _programmingLanguagesController.dispose();
    _hobbiesController.dispose();
    super.dispose();
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required.';
    }
    return null;
  }

  /// Splits a comma-separated field into a clean list, e.g.
  /// "Flutter, , Dart" becomes ["Flutter", "Dart"].
  List<String> _splitItems(String value) {
    return value
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final updated = widget.profile.copyWith(
      fullName: _nameController.text.trim(),
      studentNumber: _studentNumberController.text.trim(),
      course: _courseController.text.trim(),
      yearLevelAndSection: _yearSectionController.text.trim(),
      email: _emailController.text.trim(),
      bio: _bioController.text.trim(),
      careerGoal: _careerGoalController.text.trim(),
      skills: _splitItems(_skillsController.text),
      programmingLanguages: _splitItems(_programmingLanguagesController.text),
      hobbies: _splitItems(_hobbiesController.text),
    );

    Navigator.of(context).pop(updated);
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _sectionLabel('Student Information'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: _decoration(
                            'Full Name',
                            Icons.person_outline,
                          ),
                          textCapitalization: TextCapitalization.words,
                          validator: (value) =>
                              _required(value, 'Full name'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _studentNumberController,
                          decoration: _decoration(
                            'Student Number',
                            Icons.badge_outlined,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              _required(value, 'Student number'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _courseController,
                          decoration: _decoration(
                            'Course',
                            Icons.menu_book_outlined,
                          ),
                          textCapitalization: TextCapitalization.words,
                          validator: (value) => _required(value, 'Course'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _yearSectionController,
                          decoration: _decoration(
                            'Year Level and Section',
                            Icons.groups_outlined,
                          ),
                          validator: (value) => _required(
                            value,
                            'Year level and section',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                _sectionLabel('Contact and About'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          key: const Key('edit-email'),
                          controller: _emailController,
                          decoration: _decoration(
                            'School Email',
                            Icons.email_outlined,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            final email = value?.trim() ?? '';
                            if (email.isEmpty) return 'Email is required.';
                            if (!_emailRegex.hasMatch(email)) {
                              return 'Enter a valid email address.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _bioController,
                          decoration: _decoration(
                            'About Me',
                            Icons.person_outline,
                          ).copyWith(
                            alignLabelWithHint: true,
                            helperText: 'Keep it short: 200 characters max.',
                          ),
                          maxLines: 4,
                          maxLength: 200,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) =>
                              _required(value, 'About me'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _careerGoalController,
                          decoration: _decoration(
                            'Career Goal',
                            Icons.flag_outlined,
                          ),
                          validator: (value) =>
                              _required(value, 'Career goal'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                _sectionLabel('Skills and Interests'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _skillsController,
                          decoration: _decoration(
                            'Skills',
                            Icons.code,
                          ).copyWith(
                            helperText: 'Separate each skill with a comma.',
                          ),
                          validator: (value) => _required(value, 'Skills'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _programmingLanguagesController,
                          decoration: _decoration(
                            'Programming Languages',
                            Icons.terminal,
                          ).copyWith(
                            helperText: 'Separate each language with a comma.',
                          ),
                          validator: (value) =>
                              _required(value, 'Programming languages'),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _hobbiesController,
                          decoration: _decoration(
                            'Hobbies and Interests',
                            Icons.interests_outlined,
                          ).copyWith(
                            helperText: 'Separate each item with a comma.',
                          ),
                          validator: (value) =>
                              _required(value, 'Hobbies and interests'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Save Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
