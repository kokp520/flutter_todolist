import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todolist/models/todo.dart';

void main() {
  group('Todo Model Tests', () {
    test('should create Todo instance from Firestore document', () {
      final timestamp = Timestamp.now();
      final data = {
        'title': 'Test Todo',
        'description': 'Test Description',
        'isCompleted': false,
        'createdAt': timestamp,
      };

      final doc = FakeDocumentSnapshot(
        id: '123',
        data: data,
      );

      final todo = Todo.fromFirestore(doc);

      expect(todo.id, '123');
      expect(todo.title, 'Test Todo');
      expect(todo.description, 'Test Description');
      expect(todo.isCompleted, false);
      expect(todo.createdAt, timestamp.toDate());
    });

    test('should convert Todo to Map', () {
      final now = DateTime.now();
      final todo = Todo(
        id: '123',
        title: 'Test Todo',
        description: 'Test Description',
        isCompleted: false,
        createdAt: now,
      );

      final map = todo.toMap();

      expect(map['title'], 'Test Todo');
      expect(map['description'], 'Test Description');
      expect(map['isCompleted'], false);
      expect(map['createdAt'], Timestamp.fromDate(now));
    });
  });
}

class FakeDocumentSnapshot implements DocumentSnapshot {
  @override
  final String id;
  @override
  final Map<String, dynamic> data;

  FakeDocumentSnapshot({required this.id, required this.data});

  @override
  Map<String, dynamic> data() => data;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
} 