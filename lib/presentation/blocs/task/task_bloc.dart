// presentation/blocs/task/task_bloc.dart
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/use_cases/add_task.dart';
import '../../../domain/use_cases/delete_task.dart' as use_case;
import '../../../domain/use_cases/get_tasks.dart';
import '../../../domain/use_cases/mark_task_completed.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final use_case.DeleteTask deleteTask;
  final MarkTaskCompleted markTaskCompleted;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.deleteTask,
    required this.markTaskCompleted,
  }) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await getTasks.call();
        emit(TasksLoaded(tasks: tasks));
      } catch (_) {
        emit(TaskError());
      }
    });

    on<AddNewTask>((event, emit) async {
      try {
        await addTask.call(event.task);
        add(LoadTasks());
      } catch (_) {
        emit(TaskError());
      }
    });

    on<DeleteTask>((event, emit) async {
      try {
        await deleteTask.call(event.id);
        add(LoadTasks());
      } catch (_) {
        emit(TaskError());
      }
    });

    on<CompleteTask>((event, emit) async {
      try {
        await markTaskCompleted.call(event.id);
        add(LoadTasks());
      } catch (_) {
        emit(TaskError());
      }
    });
  }
}
