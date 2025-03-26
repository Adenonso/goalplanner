import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:star_todo/data/database.dart';
import 'package:star_todo/data/taskdatabase.dart';
import 'package:star_todo/task/goal_page.dart';
import 'package:star_todo/data/goaldatabase.dart';
import 'package:star_todo/task/taskfunctions.dart';

class GoalExtras extends StatefulWidget {
  final GoalsDatabase goal;
  final int index;
  const GoalExtras({super.key, required this.goal, required this.index});

  @override
  State<GoalExtras> createState() => _GoalExtrasState();
}

class _GoalExtrasState extends State<GoalExtras> {
  Database db = Database();

  Taskfunctions tf = Taskfunctions();

  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _progress = calculateProgress(widget.goal.tasks);
  }

  double calculateProgress(List<Taskdatabase> tasks) {
    // final completedTasks = tasks.where((task) => task.isCompleted).length;
    if (tasks.isEmpty) {
      return 0.0;
    }
    final completedTasks = tasks.where((task) => task.isCompleted).length;
    return (completedTasks / tasks.length) * 100;
  }

  void updateProgress() {
    setState(() {
      _progress = calculateProgress(widget.goal.tasks);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        //the appbar
        AppBar(
          leading: IconButton(
            icon: Icon(CupertinoIcons.arrow_left_circle),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.goal.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),

        //display goal progress
        Text(
          'Progress: ${_progress.toStringAsFixed(1)}%',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        //display date of goal creation
      ],
    ));
  }
}
