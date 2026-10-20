import 'package:flutter/material.dart';

import '../data/sample_student.dart';
import '../models/student_profile.dart';
import '../services/profile_storage.dart';
import '../theme/theme_controller.dart';
import '../widgets/info_card.dart';
import '../widgets/profile_header.dart';
import '../widgets/project_card.dart';
import '../widgets/section_title.dart';
import '../widgets/skill_chip.dart';
import 'edit_profile_page.dart';

/// The main (and only) screen: a scrollable student profile.
class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  /// Starts with the sample data; replaced by saved data if it exists.
  StudentProfile _profile = sampleStudent;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final saved = await ProfileStorage.load();
    if (!mounted || saved == null) return;
    setState(() => _profile = saved);
  }

  Future<void> _editProfile() async {
    final updated = await Navigator.of(context).push<StudentProfile>(
      MaterialPageRoute(
        builder: (_) => EditProfilePage(profile: _profile),
      ),
    );

    if (!mounted || updated == null) return;
    setState(() => _profile = updated);
    await ProfileStorage.save(updated);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeModeNotifier,
            builder: (context, mode, _) {
              final isDark = mode == ThemeMode.dark;
              return IconButton(
                tooltip: isDark
                    ? 'Switch to light theme'
                    : 'Switch to dark theme',
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: toggleThemeMode,
              );
            },
          ),
          IconButton(
            tooltip: 'Edit profile',
            icon: const Icon(Icons.edit_outlined),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileHeader(profile: _profile),
              const SizedBox(height: 22),

              // Student information.
              const SectionTitle(
                title: 'Student Information',
                icon: Icons.school_outlined,
              ),
              InfoCard(
                child: Column(
                  children: [
                    InfoRow(
                      icon: Icons.badge_outlined,
                      label: 'Student Number',
                      value: Text(_profile.studentNumber),
                    ),
                    InfoRow(
                      icon: Icons.menu_book_outlined,
                      label: 'Course',
                      value: Text(_profile.course),
                    ),
                    InfoRow(
                      icon: Icons.groups_outlined,
                      label: 'Year Level and Section',
                      value: Text(_profile.yearLevelAndSection),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Contact information.
              const SectionTitle(
                title: 'Contact Information',
                icon: Icons.mail_outlined,
              ),
              InfoCard(
                child: InfoRow(
                  icon: Icons.email_outlined,
                  label: 'School Email',
                  // Selectable so the address can be copied without
                  // needing another package.
                  value: SelectableText(_profile.email),
                ),
              ),
              const SizedBox(height: 22),

              // About me.
              const SectionTitle(
                title: 'About Me',
                icon: Icons.person_outline,
              ),
              InfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _profile.bio,
                      style: TextStyle(
                        height: 1.5,
                        color: colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    InfoRow(
                      icon: Icons.flag_outlined,
                      label: 'Career Goal',
                      value: Text(_profile.careerGoal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Skills.
              const SectionTitle(
                title: 'Skills',
                icon: Icons.build_outlined,
              ),
              InfoCard(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final skill in _profile.skills)
                      SkillChip(
                        label: skill,
                        icon: Icons.code,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Programming languages.
              const SectionTitle(
                title: 'Programming Languages',
                icon: Icons.terminal,
              ),
              if (_profile.programmingLanguages.isEmpty)
                InfoCard(
                  child: Text(
                    'No programming languages added yet.',
                    style: TextStyle(color: colors.onSurfaceVariant),
                  ),
                )
              else
                InfoCard(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final language in _profile.programmingLanguages)
                        SkillChip(
                          label: language,
                          icon: Icons.code,
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 22),

              // Projects.
              const SectionTitle(
                title: 'Projects',
                icon: Icons.folder_outlined,
              ),
              if (_profile.projects.isEmpty)
                InfoCard(
                  child: Text(
                    'No projects added yet.',
                    style: TextStyle(color: colors.onSurfaceVariant),
                  ),
                )
              else
                Column(
                  children: [
                    for (final project in _profile.projects) ...[
                      ProjectCard(project: project),
                      if (project != _profile.projects.last)
                        const SizedBox(height: 12),
                    ],
                  ],
                ),
              const SizedBox(height: 22),

              // Hobbies and interests.
              const SectionTitle(
                title: 'Hobbies and Interests',
                icon: Icons.interests_outlined,
              ),
              InfoCard(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final hobby in _profile.hobbies)
                      SkillChip(
                        label: hobby,
                        icon: Icons.favorite_outline,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
