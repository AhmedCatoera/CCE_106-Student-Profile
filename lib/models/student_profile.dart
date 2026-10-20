/// Data model for a student's profile.
///
/// Keeping the data in a model (instead of hard-coding it inside widgets)
/// makes the profile easy to update, save, and reuse.
class StudentProfile {
  final String fullName;
  final String studentNumber;
  final String course;
  final String yearLevelAndSection;
  final String email;
  final String bio;
  final String careerGoal;
  final List<String> skills;
  final List<String> programmingLanguages;
  final List<String> hobbies;
  final List<Project> projects;

  const StudentProfile({
    required this.fullName,
    required this.studentNumber,
    required this.course,
    required this.yearLevelAndSection,
    required this.email,
    required this.bio,
    required this.careerGoal,
    required this.skills,
    required this.programmingLanguages,
    required this.hobbies,
    this.projects = const [],
  });

  /// Up to three initials, e.g. "Ahmed Ibrahim Catoera" becomes "AIC".
  String get initials {
    final words = fullName
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();
    return words.take(3).map((word) => word[0].toUpperCase()).join();
  }

  StudentProfile copyWith({
    String? fullName,
    String? studentNumber,
    String? course,
    String? yearLevelAndSection,
    String? email,
    String? bio,
    String? careerGoal,
    List<String>? skills,
    List<String>? programmingLanguages,
    List<String>? hobbies,
    List<Project>? projects,
  }) {
    return StudentProfile(
      fullName: fullName ?? this.fullName,
      studentNumber: studentNumber ?? this.studentNumber,
      course: course ?? this.course,
      yearLevelAndSection: yearLevelAndSection ?? this.yearLevelAndSection,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      careerGoal: careerGoal ?? this.careerGoal,
      skills: skills ?? this.skills,
      programmingLanguages:
          programmingLanguages ?? this.programmingLanguages,
      hobbies: hobbies ?? this.hobbies,
      projects: projects ?? this.projects,
    );
  }

  /// Converts the profile to a map so it can be stored as JSON.
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'studentNumber': studentNumber,
      'course': course,
      'yearLevelAndSection': yearLevelAndSection,
      'email': email,
      'bio': bio,
      'careerGoal': careerGoal,
      'skills': skills,
      'programmingLanguages': programmingLanguages,
      'hobbies': hobbies,
      'projects': projects.map((project) => project.toJson()).toList(),
    };
  }

  /// Rebuilds a profile from the map created by [toJson].
  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      fullName: json['fullName'] as String,
      studentNumber: json['studentNumber'] as String,
      course: json['course'] as String,
      yearLevelAndSection: json['yearLevelAndSection'] as String,
      email: json['email'] as String,
      bio: json['bio'] as String,
      careerGoal: json['careerGoal'] as String,
      skills: List<String>.from(json['skills'] as List),
      // Missing key in older saved data must not crash the load.
      programmingLanguages:
          List<String>.from(json['programmingLanguages'] as List? ?? []),
      hobbies: List<String>.from(json['hobbies'] as List),
      projects: (json['projects'] as List? ?? [])
          .map((item) => Project.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// A single project shown in the Projects section.
class Project {
  final String name;
  final String description;
  final List<String> technologies;

  /// Optional link, shown as plain text (no extra packages needed).
  final String? link;

  const Project({
    required this.name,
    required this.description,
    this.technologies = const [],
    this.link,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'technologies': technologies,
      'link': link,
    };
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] as String,
      description: json['description'] as String,
      technologies: List<String>.from(json['technologies'] as List? ?? []),
      link: json['link'] as String?,
    );
  }
}
