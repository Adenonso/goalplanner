import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:star_todo/data/goaldatabase.dart';
import 'package:star_todo/data/taskdatabase.dart';
import 'package:star_todo/task/goal_page.dart';

class Taskfunctions {
  //ADD NEW TASK
  void showAddTaskDialog(
      BuildContext context, Function setState, GoalsDatabase goal, int index) {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //add task textfield
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Add a Task',
            ),
          ),

          //add and cancel button
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            //add button
            TextButton(
              onPressed: () {
                final newTask =
                    Taskdatabase(title: _controller.text, isCompleted: false);
                setState(() {
                  goal.tasks.add(newTask);
                  Hive.box<GoalsDatabase>('goalsBox').putAt(index, goal);
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Add',
                style: TextStyle(fontSize: 17, color: Colors.purple.shade800),
              ),
            ),

            //cancel button
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    // ignore: deprecated_member_use
                    MaterialStateProperty.all(Colors.purple.shade100),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel',
                  style:
                      TextStyle(fontSize: 17, color: Colors.purple.shade800)),
            ),
          ],
        );
      },
    );
  }

  //DELETE A TASK
  void showDeleteDialog(
      BuildContext context, int index, Function setState, GoalsDatabase goal) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //confirm delete action text
          content: Text(
            'Confirm Delete Task?',
            style: TextStyle(fontSize: 17),
          ),

          //yes and no button for delete action
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            //yes button
            TextButton(
              onPressed: () {
                setState(() {
                  final goalsBox = Hive.box<GoalsDatabase>('goalsBox');
                  final goalIndex = goalsBox.values.toList().indexOf(goal);
                  goalsBox.putAt(goalIndex, goal);
                });
                Navigator.of(context).pop();
              }, // Close the dialog
              child: Text(
                'Yes',
                style: TextStyle(fontSize: 17),
              ),
            ),

            //no button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No', style: TextStyle(fontSize: 17)),
            ),
          ],
        );
      },
    );
  }

  //EDIT A TASK
  void showEditActionDialog(BuildContext context, int index, Function setState,
      GoalsDatabase goal, String currentText) {
    final TextEditingController _controller = TextEditingController();

    _controller.text = currentText;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Action'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Edit action',
            ),
          ),
          actions: <Widget>[
            // Save button
            TextButton(
              onPressed: () {
                setState(() {
                  goal.tasks[index].title = _controller.text;
                  final goalsBox = Hive.box<GoalsDatabase>('goalsBox');
                  final goalIndex = goalsBox.values.toList().indexOf(goal);
                  goalsBox.putAt(goalIndex, goal);
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 17, color: Colors.purple.shade800),
              ),
            ),
            // Cancel button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 17, color: Colors.purple.shade800),
              ),
            ),
          ],
        );
      },
    );
  }
}
