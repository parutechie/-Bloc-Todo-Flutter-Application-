// domain/use_cases/add_task.dart
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class FilterTasks {
  final TaskRepository repository;

  FilterTasks(this.repository);

  Future<void> call(Task task) async {
    await repository.addTask(task);
  }
}
