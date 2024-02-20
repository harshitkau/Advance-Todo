import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extension.dart';
import 'package:todo/app/modules/home/controller.dart';
import 'package:todo/app/modules/home/widget/task_type.dart';

class AddCard extends StatelessWidget {
  final homeCntrl = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      height: squareWidth / 2,
      width: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () {
          Get.to(() => TaskType());
          homeCntrl.editController.clear();
          homeCntrl.ChangeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.grey,
              size: 10.0.wp,
            ),
          ),
        ),
      ),
    );
  }
}
