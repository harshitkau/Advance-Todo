import 'package:todo/app/data/model/task.dart';
import 'package:todo/app/data/provider/tasks/provider.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task> readTask() => taskProvider.readTask();
  void writeTask(List<Task> tasks) => taskProvider.writeTask(tasks);
}
