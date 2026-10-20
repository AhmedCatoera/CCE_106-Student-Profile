import 'package:flutter/material.dart';

/// A small rounded chip used for skills, hobbies, and technologies.
class SkillChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const SkillChip({
    super.key,
    required this.label,
    this.icon = Icons.check_circle_outline,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Chip(
      avatar: Icon(icon, size: 16, color: colors.onSecondaryContainer),
      label: Text(label),
      labelStyle: TextStyle(
        color: colors.onSecondaryContainer,
        fontSize: 13.5,
      ),
      backgroundColor: colors.secondaryContainer,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    );
  }
}
