import 'package:flutter/material.dart';

import 'screens/student_profile_page.dart';
import 'theme/app_theme.dart';
import 'theme/theme_controller.dart';

class StudentProfileApp extends StatelessWidget {
  const StudentProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Rebuilds the app whenever the theme mode changes.
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Student Profile',
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: mode,
          home: const StudentProfilePage(),
        );
      },
    );
  }
}
