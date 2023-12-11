import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/main.dart' as app;
import 'package:mp5/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Task Storage Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(app.MyApp());

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Define a task to add
    Task testTask = Task(
      id: '1', // Provide a sample id
      title: 'Test Task',
      details: 'This is a test task.',
      isCompleted: false,
    );

    // Access SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the task to SharedPreferences
    String taskString = jsonEncode([testTask.toJson()]);
    prefs.setString('tasks', taskString);

    // Trigger a rebuild
    await tester.pumpAndSettle();

    // Verify that the task is displayed on the home page
    expect(find.text('Test Task'), findsOneWidget);

    // Clean up - remove the task from SharedPreferences
    prefs.remove('tasks');
  });
}
