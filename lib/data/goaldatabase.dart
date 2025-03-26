import 'package:hive/hive.dart';
import 'taskdatabase.dart';

part 'goaldatabase.g.dart';

@HiveType(typeId: 1)
class GoalsDatabase {
  @HiveField(0)
  String title;

  @HiveField(1)
  List<Taskdatabase> tasks;

  GoalsDatabase({required this.title, this.tasks = const []});
}
