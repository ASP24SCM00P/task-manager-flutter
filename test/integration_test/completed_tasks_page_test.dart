import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/task.dart';
import 'package:mp5/views/completed_tasks_page.dart';

void main() {
  testWidgets('CompletedTasksPage displays completed tasks', (WidgetTester tester) async {
    // Create a list of completed tasks for testing
    final List<Task> completedTasks = [
      Task(id: '1', title: 'Task 1', details: 'Details 1', isCompleted: true),
      Task(id: '2', title: 'Task 2', details: 'Details 2', isCompleted: true),
      // Add more tasks as needed
    ];

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: CompletedTasksPage(completedTasks: completedTasks),
      ),
    );

    // Verify that the CompletedTasksPage displays the completed tasks.
    for (final task in completedTasks) {
      expect(find.text(task.title), findsOneWidget);
    }

    // You can add more assertions based on your app's behavior.
  });
}
