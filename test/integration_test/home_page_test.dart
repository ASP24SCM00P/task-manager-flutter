import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/task.dart';
import 'package:mp5/views/completed_tasks_page.dart';
import 'package:mp5/views/home_page.dart';

void main() {
  testWidgets('Home Page Integration Test', (tester) async {
    // Build the main app
    await tester.pumpWidget(MaterialApp(home: HomePage()));

    // Add a task to the task list
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Sample Task');
    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    // Verify that the added task is displayed
    expect(find.text('Sample Task'), findsOneWidget);

    // Mark the added task as completed
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    // Verify that the task is moved to the completed tasks list
    expect(find.text('Sample Task'), findsNothing);
    expect(find.byIcon(Icons.check), findsOneWidget);

    // Navigate to the CompletedTasksPage
    await tester.tap(find.byIcon(Icons.done));
    await tester.pumpAndSettle();

    // Verify that the completed task is displayed on the CompletedTasksPage
    expect(find.text('Sample Task'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
  });
}
