import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:star_todo/screens/home.dart';
import 'package:star_todo/data/goaldatabase.dart';
import 'package:star_todo/data/taskdatabase.dart';
import 'package:star_todo/data/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive
  await Hive.initFlutter();

  //register the adapter
  Hive.registerAdapter(TaskdatabaseAdapter());
  Hive.registerAdapter(GoalsDatabaseAdapter());

  //open the box
  await Hive.openBox<GoalsDatabase>('goalsBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
