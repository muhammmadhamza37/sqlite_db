import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../db/database_helper.dart';
import '../models/student.dart';
import '../widgets/student_card_widget.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      body: FutureBuilder<List<Student>>(
        future: DatabaseHelper.instance.getAllStudents(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if( snapshot.data.isEmpty){
              return const Center(
                child: Text('No students found'),
              );
            }


            List<Student> students = snapshot.data;

            return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  Student student = students[index];

                  return StudentCardWidget(
                    student: student,
                    onDelete: () {
                      // show alert dialog

                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Confirmation'),
                              content: const Text('Are you sure to delete ? '),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }, child: const Text('No')),
                                TextButton(
                                    onPressed: () async{
                                      Navigator.pop(context);

                                      int result = await DatabaseHelper.instance.deleteStudent(student.id!);

                                      if( result > 0 ){
                                        Fluttertoast.showToast(msg: 'Deleted');
                                        setState(() {

                                        });
                                      }else{
                                        Fluttertoast.showToast(msg: 'Failed');

                                      }
                                    }, child: const Text('Yes')),
                              ],
                            );
                          });
                    },
                    onUpdate: () {},
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}