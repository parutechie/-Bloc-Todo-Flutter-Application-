// domain/repositories/task_repository.dart
import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> markTaskCompleted(String id);
}
