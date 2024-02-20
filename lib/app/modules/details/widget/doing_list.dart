import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final homeCntrl = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCntrl.doingTodos.isEmpty && homeCntrl.doneTodos.isEmpty
        ? Column(
            children: [
              SizedBox(height: 11.0.hp),
              Image.asset(
                'assets/images/write.png',
                fit: BoxFit.cover,
                width: 65.0.wp,
              ),
              SizedBox(height: 3.0.wp),
              Text(
                'Add Task',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0.sp,
                    color: Colors.grey),
              )
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              ...homeCntrl.doingTodos
                  .map((element) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp, horizontal: 9.0.wp),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.grey[100]),
                                value: element['done'],
                                onChanged: (value) {
                                  homeCntrl.doneTodo(element['title']);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                              child: Text(
                                element['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList(),
              if (homeCntrl.doingTodos.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                  child: Divider(thickness: 2),
                ),
            ],
          ));
  }
}
