import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/data/model/task.dart';
import 'package:todo/app/modules/details/view.dart';
import 'package:todo/app/modules/home/controller.dart';

class TaskCard extends StatelessWidget {
  final homeCntrl = Get.find<HomeController>();
  final Task task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final squareWidht = Get.width - 12.0.wp;
    final color = HexColor.fromHex(task.color);
    return InkWell(
      onTap: () {
        homeCntrl.changeTask(task);
        homeCntrl.changeTodos(task.todos ?? []);
        Get.to(() => DetailsPage());
      },
      child: Container(
        width: squareWidht / 2,
        height: squareWidht / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey[300]!, blurRadius: 7, offset: Offset(0, 7))
        ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          StepProgressIndicator(
            totalSteps: homeCntrl.isTodoEmpty(task) ? 1 : task.todos!.length,
            currentStep:
                homeCntrl.isTodoEmpty(task) ? 0 : homeCntrl.getDoneTodo(task),
            size: 5,
            padding: 0,
            selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.5), color]),
            unselectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.white]),
          ),
          Padding(
            padding: EdgeInsets.all(6.0.wp),
            child: Icon(
              IconData(task.icon, fontFamily: 'MaterialIcons'),
              color: color,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(6.0.wp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0.sp),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.0.wp),
                Text(
                  '${task.todos?.length ?? 0} Tasks',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
