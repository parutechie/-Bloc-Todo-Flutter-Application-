// presentation/blocs/task/task_event.dart
part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class LoadTasks extends TaskEvent {}

class AddNewTask extends TaskEvent {
  final Task task;

  const AddNewTask(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TaskEvent {
  final String id;

  const DeleteTask(this.id);

  @override
  List<Object> get props => [id];
}

class CompleteTask extends TaskEvent {
  final String id;

  const CompleteTask(this.id);

  @override
  List<Object> get props => [id];
}
