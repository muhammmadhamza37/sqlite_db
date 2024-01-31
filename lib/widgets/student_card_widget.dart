import 'package:flutter/material.dart';
import 'package:sqlite_db/widgets/student_item_info_widget.dart';
import '../models/student.dart';
class StudentCardWidget extends StatelessWidget {
  final Student student;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;
  const StudentCardWidget({super.key, required this.student, required this.onDelete, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      color: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          children: [
              
          StudentItemInfoWidget(title: 'ID', value: student.id.toString()),
          StudentItemInfoWidget(title: 'Name', value: student.name),
          StudentItemInfoWidget(title: 'Email', value: student.email),
          StudentItemInfoWidget(title: 'Mobile', value: student.mobile),
          StudentItemInfoWidget(title: 'Course', value: student.course),
          StudentItemInfoWidget(title: 'Uni', value: student.uni),
          Row(children: [
            Expanded(child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                ),
                onPressed: onDelete, child: const Text('Delete'))),
            const SizedBox(width: 100,),
            Expanded(child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: onUpdate, child: const Text('Update'))),

          ],)
        ],),
      ),);
  }
}