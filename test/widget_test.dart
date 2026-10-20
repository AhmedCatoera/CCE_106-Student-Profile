// Basic smoke tests for the student profile app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:student_profile_app/student_profile_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Pretend nothing has been saved on the device yet.
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('shows the profile header and main sections',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StudentProfileApp());
    await tester.pumpAndSettle();

    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Ahmed Ibrahim Catoera'), findsOneWidget);
    expect(find.text('Student Information'), findsOneWidget);
    expect(find.text('Skills'), findsOneWidget);
    expect(find.text('Programming Languages'), findsOneWidget);
    expect(find.text('Java'), findsOneWidget);
    expect(find.text('Projects'), findsOneWidget);
    expect(find.text('Student Profile App'), findsOneWidget);
  });

  testWidgets('edit screen rejects an invalid email address',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StudentProfileApp());
    await tester.pumpAndSettle();

    // Open the edit screen.
    await tester.tap(find.byTooltip('Edit profile'));
    await tester.pumpAndSettle();
    expect(find.text('Edit Profile'), findsOneWidget);

    // Replace the email with an invalid value and save.
    final emailField = find.byKey(const Key('edit-email'));
    await tester.enterText(emailField, 'not-an-email');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Validation should block saving and show an error.
    expect(find.text('Enter a valid email address.'), findsOneWidget);
    expect(find.text('My Profile'), findsNothing);

    // Fixing the email should close the edit screen.
    await tester.enterText(emailField, 'a.catoera.558621@umindanao.edu.ph');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('My Profile'), findsOneWidget);
  });
}
