import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/presentation/blocs/task/task_bloc.dart';

class TaskCreate extends StatefulWidget {
  const TaskCreate({super.key});

  @override
  State<TaskCreate> createState() => _TaskCreateState();
}

class _TaskCreateState extends State<TaskCreate> {
  final TextEditingController taskTilteController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //tilte
            Column(
              children: [
                const Column(
                  children: [
                    Text(
                      'Add Task',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(
                      indent: 50,
                      endIndent: 50,
                      thickness: 1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),

                //title with texfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: taskTilteController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.deepPurpleAccent),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(
                            CupertinoIcons.bookmark,
                            color: Colors.black,
                          ),
                          hintText: 'Title',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      //description
                      TextField(
                        maxLines: 5,
                        controller: taskDescriptionController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.deepPurpleAccent),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Description',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancel'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent, // Text color
                  ),
                ),
                const SizedBox(width: 20), // Add spacing between buttons
                ElevatedButton.icon(
                  onPressed: () {
                    if (taskTilteController.text.isNotEmpty) {
                      final newTask = Task(
                          id: DateTime.now().toString(),
                          title: taskTilteController.text,
                          isCompleted: false,
                          description: '');
                      context.read<TaskBloc>().add(AddNewTask(newTask));
                      Navigator.of(context).pop();
                    }
                  },
                  icon: const Icon(CupertinoIcons.add_circled_solid),
                  label: const Text('Add'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurpleAccent, // Text color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
