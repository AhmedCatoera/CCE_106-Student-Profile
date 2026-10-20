import 'package:flutter/material.dart';

import '../models/student_profile.dart';

/// Profile header shown at the top of the profile screen.
///
/// The student's name is the most prominent element, followed by
/// the course, year level, and a short career tagline.
class ProfileHeader extends StatelessWidget {
  final StudentProfile profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Semantics(
                label: 'Profile picture of ${profile.fullName}',
                excludeSemantics: true,
                child: CircleAvatar(
                  radius: 46,
                  backgroundColor: colors.primaryContainer,
                  child: Text(
                    profile.initials,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: colors.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                profile.fullName,
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${profile.course} • ${profile.yearLevelAndSection}',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: colors.secondaryContainer,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.workspace_premium_outlined,
                      size: 16,
                      color: colors.onSecondaryContainer,
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        profile.careerGoal,
                        style: textTheme.labelMedium?.copyWith(
                          color: colors.onSecondaryContainer,
                        ),
                      ),
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
