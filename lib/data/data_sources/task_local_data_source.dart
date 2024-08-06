// data/data_sources/task_local_data_source.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/task_model.dart';

class TaskLocalDataSource {
  final SharedPreferences sharedPreferences;

  TaskLocalDataSource({required this.sharedPreferences});

  static const String TASKS_KEY = 'TASKS_KEY';

  Future<List<TaskModel>> getTasks() async {
    final jsonString = sharedPreferences.getString(TASKS_KEY);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final jsonString = json.encode(tasks.map((task) => task.toJson()).toList());
    await sharedPreferences.setString(TASKS_KEY, jsonString);
  }
}
