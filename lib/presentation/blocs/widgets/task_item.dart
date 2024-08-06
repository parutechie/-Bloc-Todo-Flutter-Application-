// presentation/widgets/task_item.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/blocs/task/task_bloc.dart';
import '../../../domain/entities/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, 4),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //check box
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: task.isCompleted,
                    onChanged: (_) {
                      BlocProvider.of<TaskBloc>(context)
                          .add(CompleteTask(task.id));
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),

                  //Ttile
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        task.description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  BlocProvider.of<TaskBloc>(context).add(DeleteTask(task.id));
                },
                child: const Icon(
                  CupertinoIcons.delete,
                  color: Colors.grey,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//  @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(task.title),
//       subtitle: Text(task.description),
//       leading: Checkbox(
//         value: task.isCompleted,
//         onChanged: (_) {
//           BlocProvider.of<TaskBloc>(context).add(CompleteTask(task.id));
//         },
//       ),
//       trailing: IconButton(
//         icon: const Icon(
//           Icons.delete,
//           color: Colors.red,
//         ),
//         onPressed: () {
//           BlocProvider.of<TaskBloc>(context).add(DeleteTask(task.id));
//         },
//       ),
//     );
//   }
// }
