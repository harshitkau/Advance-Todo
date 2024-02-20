import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/data/model/task.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/modules/home/widget/add_Card.dart';
import 'package:todo/app/modules/home/widget/add_dialog.dart';
import 'package:todo/app/modules/home/widget/task_Card.dart';
import 'package:todo/app/modules/reports/view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Text(
                      "My List",
                      style: TextStyle(fontSize: 24.0.sp),
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map(
                              (element) => LongPressDraggable(
                                  data: element,
                                  onDragStarted: () =>
                                      controller.changeDeleting(true),
                                  onDraggableCanceled: (_, __) =>
                                      controller.changeDeleting(false),
                                  onDragEnd: (_) =>
                                      controller.changeDeleting(false),
                                  feedback: Opacity(
                                    opacity: 0.8,
                                    child: TaskCard(task: element),
                                  ),
                                  child: TaskCard(task: element)),
                            )
                            .toList(),
                        AddCard(),
                        // TaskType()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ReportPage()
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: Obx(
          () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: Icon(Icons.apps),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.0.wp),
                    child: Icon(Icons.data_usage_sharp),
                  ),
                  label: 'Report')
            ],
          ),
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(
                    () => AddDialog(),
                    transition: Transition.downToUp,
                  );
                } else {
                  EasyLoading.showInfo('Please Create a Task Type');
                }
              },
              backgroundColor: controller.deleting.value ? Colors.red : blue,
              child: Icon(
                controller.deleting.value ? Icons.delete : Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Deleted successfully');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
