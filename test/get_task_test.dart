// test/domain/use_cases/get_tasks_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/repositories/task_repository.dart';
import 'package:todo/domain/use_cases/get_tasks.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late GetTasks useCase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    useCase = GetTasks(mockTaskRepository);
  });

  final tasks = [
    Task(id: '1', description: 'Test Task 1', title: 'Test2'),
    Task(id: '2', description: 'Test Task 2', title: 'Test2'),
  ];

  test('should get tasks from the repository', () async {
    // arrange
    when(mockTaskRepository.getTasks()).thenAnswer((_) async => tasks);
    // act
    final result = await useCase();
    // assert
    expect(result, tasks);
    verify(mockTaskRepository.getTasks());
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
