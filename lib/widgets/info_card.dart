import 'package:flutter/material.dart';

/// A consistent card with rounded corners and padding.
///
/// The visual style itself comes from the app theme's `cardTheme`.
class InfoCard extends StatelessWidget {
  final Widget child;

  const InfoCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

/// A single labelled row used inside an [InfoCard].
///
/// The label keeps the meaning of each value clear for readers
/// and for screen readers.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: colors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                DefaultTextStyle.merge(
                  style: textTheme.bodyLarge,
                  child: value,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
