import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'student_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Student> studentBox;

  @override
  void initState() {
    super.initState();
    studentBox = Hive.box<Student>('studentBox');
  }

  void addSampleStudent() {
    final student = Student(
      name: 'Rifana Sherin',
      age: 18,
      course: 'Flutter Developer',
    );

    studentBox.add(student);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Student Records'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addSampleStudent,
        child:  Icon(Icons.add),
      ),
      body: ValueListenableBuilder<Box<Student>>(
        valueListenable: studentBox.listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return  Center(
              child: Text('No student records'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final student = box.getAt(index)!;
              return ListTile(
                title: Text(student.name),
                subtitle: Text(
                  '${student.course} | Age: ${student.age}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
