import '../models/student_profile.dart';

/// Sample data used when no saved profile exists yet.
const sampleStudent = StudentProfile(
  fullName: 'Ahmed Ibrahim Catoera',
  studentNumber: '2026-558621',
  course: 'BS Information Technology',
  yearLevelAndSection: '3rd Year - CCE106',
  email: 'a.catoera.558621@umindanao.edu.ph',
  bio: 'I am an IT student who enjoys learning '
      'about technology and creating applications.',
  careerGoal: 'Aspiring Mobile Developer',
  skills: [
    'Full Stack Developer',
    'Project Management',
    'Web Development',
    'Programming'
  ],
  programmingLanguages: [
    'Java',
    'HTML',
    'CSS',
    'JavaScript',
    'C#',
    '.NET VB',
    'C++',
    'PHP',
  ],
  hobbies: ['Coding', 'Reading', 'Cycling', 'Thrifting'],
  projects: [
    Project(
      name: 'Student Profile App',
      description:
          'A mobile app that presents an editable student profile with '
          'light and dark themes and locally saved changes.',
      technologies: ['Flutter', 'Dart'],
    ),
    Project(
      name: 'Sweetnest Inventory and Order Management System',
      description: 'A system that helps organizing the business inventory '
          'and customers orders',
      technologies: ['Laravel', 'Mysql'],
      link: 'https://github.com/AhmedCatoera/IT12-Project',
    ),
  ],
);
