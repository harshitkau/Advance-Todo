import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  final homeCntrl = Get.find<HomeController>();
  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCntrl.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5.0.wp, vertical: 2.0.wp),
                  child: Text(
                    'Completed (${homeCntrl.doneTodos.length})',
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ...homeCntrl.doneTodos.map((element) => Dismissible(
                      key: ObjectKey(element),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => homeCntrl.deleteDoneTodo(element),
                      background: Container(
                        color: Colors.red.withOpacity(0.8),
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.0.wp),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 9.0.wp, vertical: 3.0.wp),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Icon(
                                Icons.done,
                                color: Colors.blue,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                              child: Text(
                                element['title'],
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            )
          : Container(),
    );
  }
}
