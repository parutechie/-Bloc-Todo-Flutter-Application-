// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/domain/repositories/task_repository.dart';
import 'package:todo/domain/use_cases/delete_task.dart' as use_case;
import 'package:todo/presentation/blocs/pages/task_page.dart';
import 'data/data_sources/task_local_data_source.dart';
import 'data/repositories/task_repository_impl.dart';
import 'domain/use_cases/add_task.dart';
import 'domain/use_cases/get_tasks.dart';
import 'domain/use_cases/mark_task_completed.dart';
import 'presentation/blocs/task/task_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<TaskLocalDataSource>(
      () => TaskLocalDataSource(sharedPreferences: sl()));
  sl.registerLazySingleton<TaskRepository>(
      () => TaskRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => use_case.DeleteTask(sl()));
  sl.registerLazySingleton(() => MarkTaskCompleted(sl()));
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TaskBloc(
            getTasks: sl(),
            addTask: sl(),
            deleteTask: sl(),
            markTaskCompleted: sl(),
          )..add(LoadTasks()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskPage(),
      ),
    );
  }
}
