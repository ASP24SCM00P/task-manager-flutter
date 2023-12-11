import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mp5/main.dart' as app;
import 'package:mp5/views/completed_tasks_page.dart';
import 'package:mp5/shared_preferences_helper.dart';

void main() async {
  // Ensure that the widgets binding is initialized
 // WidgetsFlutterBinding.ensureInitialized();

  // Set up the shared_preferences mock
  SharedPreferences.setMockInitialValues({});

  // Initialize SharedPreferencesHelper
  await SharedPreferencesHelper.initialize();

  // Now you can run your tests
  testWidgets('Test CompletedTasksPage', (WidgetTester tester) async {
    // Create a list of completed tasks for testing
    List<Task> completedTasks = [
      Task(id: '1', title: 'Task 1', isCompleted: true),
      Task(id: '2', title: 'Task 2', isCompleted: true),
    ];

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CompletedTasksPage(completedTasks: completedTasks),
      ),
    );

    // You can add your test expectations here
    expect(find.text('Finished Tasks'), findsOneWidget);
    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Task 2'), findsOneWidget);
  }, tags: ['CompletedTasksPage']);
}
