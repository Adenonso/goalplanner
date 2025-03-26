import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:star_todo/components/my_button.dart';
import 'package:star_todo/data/database.dart';
import 'package:star_todo/data/goaldatabase.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:star_todo/data/taskdatabase.dart';
import 'package:star_todo/task/goal_extras.dart';
import 'package:star_todo/task/taskfunctions.dart';

class GoalPage extends StatefulWidget {
  final GoalsDatabase goal;
  final int index;
  GoalPage({
    super.key,
    required this.goal,
    required this.index,
  });

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  // final GoalsDatabase _goalsDatabase = GoalsDatabase(title: 'Goals');

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
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
            actions: [
              IconButton(
                icon: Icon(Icons.auto_graph_sharp),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoalExtras(
                        goal: widget.goal,
                        index: widget.index,
                      ),
                    ),
                  );
                },
              )
            ],
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

          Text(
            'Progress: ${_progress.toStringAsFixed(1)}%',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          //set a deadline for the goal
          Deadline_Button(),

          //text widget
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: const Text(
              'Add some actions to acheive these tasks (At least one action).',
              style: TextStyle(fontSize: 17),
            ),
          ),

          //task list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                child: ListView.builder(
                  itemCount: widget.goal.tasks.length,
                  itemBuilder: (context, index) {
                    final task = widget.goal.tasks[index];
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        tileColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        title: Text(task.title),
                        //CHECKBOX
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) {
                            setState(() {
                              task.isCompleted = value!;
                              Hive.box<GoalsDatabase>('goalsBox')
                                  .putAt(widget.index, widget.goal);
                              updateProgress();
                            });
                          },
                        ),
                        //EDIT TASK
                        onTap: () {
                          tf.showEditActionDialog(
                            context,
                            index,
                            setState,
                            widget.goal,
                            widget.goal.tasks[index].title,
                          );
                        },
                        //DELETE TASK
                        trailing: IconButton(
                          onPressed: () {
                            // showDeleteDialog(context, index);
                            tf.showDeleteDialog(
                              context,
                              widget.index,
                              setState,
                              widget.goal,
                            );
                          },
                          icon: Icon(
                            CupertinoIcons.delete,
                            size: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          //add extra actions and save the goal
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                //ADD A NEW TASK
                MyButton(
                    onPressed: () => tf.showAddTaskDialog(
                        context, setState, widget.goal, widget.index),
                    buttonTitle: "Add")
              ],
            ),
          )
        ],
      ),
    );
  }

  //CHECK THE RANDOM FILE FOR THE INITIAL FUNCTIONS IN THIS PAGE B4 TRANSFERED TO TASKFUNCTIONS
}
