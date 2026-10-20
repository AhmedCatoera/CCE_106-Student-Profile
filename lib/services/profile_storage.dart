import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/student_profile.dart';

/// Saves and loads the student profile on the device.
///
/// The profile is stored as a JSON string with `shared_preferences`,
/// so edits remain after the app closes.
class ProfileStorage {
  static const _key = 'student_profile_json';

  /// Returns the saved profile, or `null` if nothing valid is stored.
  static Future<StudentProfile?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return null;

    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;

      // Data saved before the Programming Languages field existed cannot
      // contain it; ignore it so the sample profile (with its languages)
      // is shown instead of an empty list.
      if (json['programmingLanguages'] == null) return null;

      return StudentProfile.fromJson(json);
    } catch (_) {
      // Stored data is damaged or from an older version; ignore it.
      return null;
    }
  }

  /// Stores the profile on the device.
  static Future<void> save(StudentProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(profile.toJson()));
  }
}
