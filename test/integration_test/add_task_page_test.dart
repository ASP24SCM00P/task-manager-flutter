import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/task.dart';

import 'package:mp5/views/add_tasks_page.dart';

void main() {
  testWidgets('AddTaskPage adds a new task', (WidgetTester tester) async {
    // Variable to store the added task
    late Task addedTask;

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: AddTaskPage(
          onTaskAdded: (task) {
            addedTask = task;
          },
        ),
      ),
    );

    // Verify that the AddTaskPage is displayed.
    expect(find.text('Add Task'), findsOneWidget);

    // Enter a task name in the TextField.
    await tester.enterText(find.byType(TextField), 'New Task');

    // Submit the form.
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    // Verify that the onTaskAdded callback was called with the correct task.
    expect(addedTask.title, 'New Task');
    expect(addedTask.details, '');
    expect(addedTask.isCompleted, false);
    expect(addedTask.id, isNotNull);

    // You can add more assertions based on your app's behavior.
  });
}
