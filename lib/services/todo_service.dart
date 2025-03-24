import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo.dart';
import 'auth_service.dart';

class TodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  // 獲取所有 todos
  Stream<List<Todo>> getTodos() {
    final user = _authService.currentUser;
    if (user == null) return Stream.value([]);

    return _firestore
        .collection('todos')
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Todo.fromFirestore(doc)).toList();
        });
  }

  // 新增 todo
  Future<void> addTodo(String title, String description) async {
    final user = _authService.currentUser;
    if (user == null) throw Exception('User not authenticated');

    await _firestore.collection('todos').add({
      'title': title,
      'description': description,
      'isCompleted': false,
      'userId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // 更新 todo
  Future<void> toggleTodoStatus(Todo todo) async {
    final user = _authService.currentUser;
    if (user == null) throw Exception('User not authenticated');
    if (todo.userId != user.uid) throw Exception('Unauthorized access');

    await _firestore.collection('todos').doc(todo.id).update({
      'isCompleted': !todo.isCompleted,
    });
  }

  // 刪除 todo
  Future<void> deleteTodo(Todo todo) async {
    final user = _authService.currentUser;
    if (user == null) throw Exception('User not authenticated');
    if (todo.userId != user.uid) throw Exception('Unauthorized access');

    await _firestore.collection('todos').doc(todo.id).delete();
  }
}
