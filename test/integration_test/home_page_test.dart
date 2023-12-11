import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mp5/main.dart' as app;
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test HomePage', (WidgetTester tester) async {
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

    // Verify that the initial state of your app is correct
    expect(find.text('To-Do List App'), findsOneWidget);
    expect(find.text('Task 1'), findsOneWidget);

    // You can add more assertions based on your app's behavior.
  });
}
