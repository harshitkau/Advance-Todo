import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/data/model/task.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/widget/icons.dart';

class TaskType extends StatelessWidget {
  final homeCntrl = Get.find<HomeController>();
  TaskType({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: homeCntrl.formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      homeCntrl.editController.clear();
                      homeCntrl.changeTask(null);
                    },
                    icon: Icon(Icons.close),
                  ),
                  TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        if (homeCntrl.formKey.currentState!.validate()) {
                          int icon =
                              icons[homeCntrl.chipIndex.value].icon!.codePoint;
                          String color =
                              icons[homeCntrl.chipIndex.value].color!.toHex();
                          var task = Task(
                            title: homeCntrl.editController.text,
                            icon: icon,
                            color: color,
                          );
                          Get.back();
                          homeCntrl.addTask(task)
                              ? EasyLoading.showSuccess('Create Sucessfully')
                              : EasyLoading.showError('Duplicate Task');
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: 14.0.sp),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                "Task Type",
                style:
                    TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
              child: TextFormField(
                controller: homeCntrl.editController,
                decoration: InputDecoration(
                  labelText: 'Enter Task Title',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter Your Task Title';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
              child: Text(
                'Add to',
                style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 5.0.wp, horizontal: 6.0.wp),
              child: Wrap(
                spacing: 2.0.wp,
                children: icons
                    .map((e) => Obx(() {
                          final index = icons.indexOf(e);
                          return ChoiceChip(
                            selectedColor:
                                const Color.fromARGB(255, 137, 194, 240)
                                    .withOpacity(0.5),
                            pressElevation: 0,
                            backgroundColor: Colors.white.withOpacity(0.05),
                            label: e,
                            checkmarkColor: Colors.red,
                            selected: homeCntrl.chipIndex.value == index,
                            onSelected: (bool selected) {
                              homeCntrl.chipIndex.value = selected ? index : 0;
                            },
                          );
                        }))
                    .toList(),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  minimumSize: const Size(150, 40),
                ),
                onPressed: () {
                  if (homeCntrl.formKey.currentState!.validate()) {
                    int icon = icons[homeCntrl.chipIndex.value].icon!.codePoint;
                    String color =
                        icons[homeCntrl.chipIndex.value].color!.toHex();
                    var task = Task(
                      title: homeCntrl.editController.text,
                      icon: icon,
                      color: color,
                    );
                    Get.back();
                    homeCntrl.addTask(task)
                        ? EasyLoading.showSuccess('Create Sucessfully')
                        : EasyLoading.showError('Duplicate Task');
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
