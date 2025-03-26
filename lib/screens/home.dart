import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:star_todo/components/my_drawer.dart';
import 'package:star_todo/data/database.dart';
import 'package:star_todo/task/goal_page.dart';
import 'package:star_todo/data/goaldatabase.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //refence to the hive mainBox created in the main.dart
  final GoalsDatabase _goalsDatabase =
      GoalsDatabase(title: Text('Goals').toString());

  Database db = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: MyDrawer(),
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        scrolledUnderElevation: 20,
        backgroundColor: Colors.white,
        title: const Text(
          "G o a l s P l a n n e r",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<GoalsDatabase>('goalsBox').listenable(),
                builder: (context, Box<GoalsDatabase> box, _) {
                  final goals = box.values.toList();
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    itemCount: goals.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(15.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          tileColor: Colors.white,
                          title: Text(goals[index].title),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GoalPage(
                                        goal: goals[index], index: index)));
                          },
                          onLongPress: () {
                            _showDeleteDialog(context, index);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          _showAddGoalDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  //TO ADD A NEW GOAL
  void _showAddGoalDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Add Goal'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Goal Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newGoal =
                    GoalsDatabase(title: _controller.text, tasks: []);
                setState(() {
                  db.addGoal(newGoal);
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

//TO DELETE A GOAL
  void _showDeleteDialog(BuildContext context, int index) {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm delete of goal?'),
          // content: Text(_controller.text),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  db.deleteGoal(index);
                });
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
