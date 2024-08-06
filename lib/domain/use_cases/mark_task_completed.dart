// domain/use_cases/mark_task_completed.dart
import '../repositories/task_repository.dart';

class MarkTaskCompleted {
  final TaskRepository repository;

  MarkTaskCompleted(this.repository);

  Future<void> call(String id) async {
    return repository.markTaskCompleted(id);
  }
}
