// test/presentation/pages/task_page_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/blocs/pages/task_page.dart';
import 'package:todo/presentation/blocs/task/task_bloc.dart';

class MockTaskBloc extends MockBloc<TaskEvent, TaskState> implements TaskBloc {}

void main() {
  late MockTaskBloc mockTaskBloc;

  setUp(() {
    mockTaskBloc = MockTaskBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<TaskBloc>(
        create: (context) => mockTaskBloc,
        child: const TaskPage(),
      ),
    );
  }

  testWidgets('should render tasks when state is TasksLoaded',
      (WidgetTester tester) async {
    // arrange
    whenListen(
      mockTaskBloc,
      Stream.fromIterable([
        const TasksLoaded(tasks: [
          Task(id: '1', description: 'Test Task 1', title: 'Test1'),
          Task(id: '2', description: 'Test Task 2', title: 'Test2'),
        ])
      ]),
      initialState: TaskInitial(),
    );

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.text('Test Task 1'), findsOneWidget);
    expect(find.text('Test Task 2'), findsOneWidget);
  });
}
