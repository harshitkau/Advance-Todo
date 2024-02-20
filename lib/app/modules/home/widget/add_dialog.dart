import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/core/values/colors.dart';
import 'package:todo/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final HomeCntrl = Get.find<HomeController>();
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: HomeCntrl.formKey,
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
                      HomeCntrl.editController.clear();
                      HomeCntrl.changeTask(null);
                    },
                    icon: Icon(Icons.close),
                  ),
                  TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        if (HomeCntrl.formKey.currentState!.validate()) {
                          if (HomeCntrl.task.value == null) {
                            EasyLoading.showError(
                                'Please Select Your Task Type');
                          } else {
                            var sucess = HomeCntrl.updateTask(
                              HomeCntrl.task.value!,
                              HomeCntrl.editController.text,
                            );
                            if (sucess) {
                              EasyLoading.showSuccess(
                                  'Todo Item Added Successfully');
                              Get.back();
                              HomeCntrl.changeTask(null);
                            } else {
                              EasyLoading.showError('Todo Item Already Exists');
                            }
                            HomeCntrl.editController.clear();
                          }
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
                "New Task",
                style:
                    TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
              child: TextFormField(
                controller: HomeCntrl.editController,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter Your Todo Item';
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
            ...HomeCntrl.tasks
                .map((element) => Obx(
                      () => InkWell(
                        onTap: () => HomeCntrl.changeTask(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 5.0.wp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(element.icon,
                                        fontFamily: 'MaterialIcons'),
                                    color: HexColor.fromHex(element.color),
                                  ),
                                  SizedBox(width: 3.0.wp),
                                  Text(
                                    element.title,
                                    style: TextStyle(
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              if (HomeCntrl.task.value == element)
                                const Icon(Icons.check, color: blue)
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
