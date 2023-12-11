import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mp5/main.dart' as app;
import 'package:mp5/views/add_tasks_page.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test AddTaskPage', (WidgetTester tester) async {
    // Mock SharedPreferences
    final mockSharedPreferences = MockSharedPreferences();
    when(mockSharedPreferences.getString('tasks')).thenReturn('[]');
    when(mockSharedPreferences.getString('completedTasks')).thenReturn('[]');
    SharedPreferences.setMockInitialValues({});

    // Provide the mockSharedPreferences to the SharedPreferences.getInstance method
    SharedPreferences.setMockInitialValues({
      'tasks': '[{"id":"1","title":"Task 1","isCompleted":false,"details":""}]',
      'completedTasks': '[]',
    });

    // Run the app
    app.main();

    // Wait for the app to render
    await tester.pumpAndSettle();

    // Find and tap on the FloatingActionButton to navigate to AddTaskPage
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that AddTaskPage is displayed
    expect(find.text('Add Task'), findsOneWidget);

    // Enter task name in the TextField
    await tester.enterText(find.byType(TextField), 'Test Task');

    // Submit the form
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    // Verify that the task is added
    expect(find.text('Test Task'), findsOneWidget);

   
  }, tags: ['AddTaskPage']);
}
