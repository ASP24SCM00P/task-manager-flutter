import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/main.dart'; // Replace with the actual path to your main.dart file
import 'package:mp5/views/add_tasks_page.dart';

void main() {
  testWidgets('Navigate to Add Task Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('Today\'s Tasks'), findsOneWidget);

    // Tap the add button to navigate to Add Task Page
    await tester.tap(find.byKey(Key('fab')));
    await tester.pumpAndSettle();

    // Verify that we are on the Add Task Page
    expect(find.text('Enter Task Name:'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
