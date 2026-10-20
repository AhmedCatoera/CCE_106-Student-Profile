import 'package:flutter/material.dart';

import '../models/student_profile.dart';
import 'skill_chip.dart';

/// A compact card that presents one student project.
class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.folder_open_outlined, color: colors.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    project.name,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              project.description,
              style: textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            if (project.technologies.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final technology in project.technologies)
                    SkillChip(
                      label: technology,
                      icon: Icons.code,
                    ),
                ],
              ),
            ],
            if (project.link != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.link, size: 16, color: colors.primary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: SelectableText(
                      project.link!,
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
