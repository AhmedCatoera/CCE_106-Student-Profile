import 'package:flutter/material.dart';

/// App-wide theme mode, shared without any extra packages.
///
/// The app starts on [ThemeMode.system] and the profile screen can switch
/// between light and dark with [toggleThemeMode].
final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier<ThemeMode>(ThemeMode.system);

/// Switches between the light and dark themes.
void toggleThemeMode() {
  final isDark = themeModeNotifier.value == ThemeMode.dark;
  themeModeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark;
}
