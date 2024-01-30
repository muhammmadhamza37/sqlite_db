import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqlite_db/screens/student_list_screen.dart';
import '../db/database_helper.dart';
import '../models/student.dart';
import '../utilitiy/data_store.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String name, email, mobile, uni;

  String _selectedCourse = courses[0];
  String _selectedUniversity = universities[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide value';
                  }

                  name = text;
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide value';
                  }

                  email = text;
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Mobile',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide value';
                  }

                  mobile = text;
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownButtonFormField(
                value: _selectedCourse,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    _selectedCourse = value!;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    _selectedCourse = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "can't empty";
                  } else {
                    return null;
                  }
                },
                items: courses.map((String val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownButtonFormField(
                value: _selectedUniversity,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    _selectedUniversity = value!;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    _selectedUniversity = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "can't empty";
                  } else {
                    return null;
                  }
                },
                items: universities.map((String val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      // Save student
                      Student student = Student(
                        name: name,
                        email: email,
                        mobile: mobile,
                        course: _selectedCourse,
                        uni: _selectedUniversity,
                      );

                      int result = await DatabaseHelper.instance.saveStudent(student);

                      if( result > 0 ){
                        print(result);
                        Fluttertoast.showToast(msg: 'Record Saved', backgroundColor: Colors.green);

                        formKey.currentState!.reset();
                      }else{
                        print(result);
                        Fluttertoast.showToast(msg: 'Failed', backgroundColor: Colors.red);

                      }
                    }
                  },
                  child: const Text('Save')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const StudentListScreen();
                    }));
                  },
                  child: const Text('View All')),
            ],
          ),
        ),
      ),
    );
  }
}