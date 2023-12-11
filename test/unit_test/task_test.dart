import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/task.dart';


void main() {
  group('Task Model Tests', () {
    // Test 1
    test('Task should have a valid title', () {
      Task task = Task(id: '1', title: 'Sample Task');
      expect(task.title, 'Sample Task');
    });

    // Test 2
    test('Task should be initially not completed', () {
      Task task = Task(id: '1', title: 'Sample Task');
      expect(task.isCompleted, isFalse);
    });

    // Test 3
    test('Task should be marked as completed', () {
      Task task = Task(id: '1', title: 'Sample Task');
      task.setCompleted(true);
      expect(task.isCompleted, isTrue);
    });

    // Test 4
    test('Task should be deleted successfully', () {
      Task task = Task(id: '1', title: 'Sample Task');
      bool isDeleted = false;

      task.deleteTask((deletedTask) {
        isDeleted = true;
      });

      expect(isDeleted, isTrue);
    });

    // Test 5
    test('Task should be created from JSON', () {
      Map<String, dynamic> json = {
        'id': '1',
        'title': 'Sample Task',
        'isCompleted': true,
        'details': 'Some details',
      };

      Task task = Task.fromJson(json);
      expect(task.id, '1');
      expect(task.title, 'Sample Task');
      expect(task.isCompleted, isTrue);
      expect(task.details, 'Some details');
    });

    // Test 6
    test('Task should be converted to JSON', () {
      Task task = Task(id: '1', title: 'Sample Task', isCompleted: true, details: 'Some details');
      Map<String, dynamic> json = task.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Sample Task');
      expect(json['isCompleted'], isTrue);
      expect(json['details'], 'Some details');
    });
  });
}
