// data/repositories/task_repository_impl.dart
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../data_sources/task_local_data_source.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Task>> getTasks() async {
    final taskModels = await localDataSource.getTasks();
    return taskModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addTask(Task task) async {
    final taskModels = await localDataSource.getTasks();
    taskModels.add(TaskModel.fromEntity(task));
    await localDataSource.saveTasks(taskModels);
  }

  @override
  Future<void> deleteTask(String id) async {
    final taskModels = await localDataSource.getTasks();
    taskModels.removeWhere((task) => task.id == id);
    await localDataSource.saveTasks(taskModels);
  }

  @override
  Future<void> markTaskCompleted(String id) async {
    final taskModels = await localDataSource.getTasks();
    final index = taskModels.indexWhere((task) => task.id == id);
    if (index != -1) {
      taskModels[index] = taskModels[index].copyWith(isCompleted: true);
      await localDataSource.saveTasks(taskModels);
    }
  }
}
