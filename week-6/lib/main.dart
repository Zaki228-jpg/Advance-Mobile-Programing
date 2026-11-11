import 'package:flutter/material.dart';

void main() {
  runApp(const Week3App());
}

// =======================================
// MAIN APPLICATION
// =======================================

class Week3App extends StatelessWidget {
  const Week3App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Week 3 Dart Labs',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const HomePage(),
    );
  }
}

// =======================================
// HOME PAGE
// =======================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final labs = [
      ('Lab 1 - Dart Basics', Icons.code, const Lab1Page()),
      ('Lab 2 - Conditions & Loops', Icons.loop, const Lab2Page()),
      ('Lab 3 - Lists', Icons.list, const Lab3Page()),
      ('Lab 4 - Classes & Constructors', Icons.school, const Lab4Page()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Week 3 - Dart Programming')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.flutter_dash, size: 85, color: Colors.indigo),
          const SizedBox(height: 15),
          const Text(
            'Advanced Mobile Programming',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('Four Practical Labs', textAlign: TextAlign.center),
          const SizedBox(height: 25),
          for (final lab in labs)
            Card(
              child: ListTile(
                leading: Icon(lab.$2, color: Colors.indigo),
                title: Text(lab.$1),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => lab.$3),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// =======================================
// REUSABLE RESULT WIDGET
// =======================================

class ResultPage extends StatelessWidget {
  final String title;
  final List<String> results;

  const ResultPage({super.key, required this.title, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: results.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(results[index], style: const TextStyle(fontSize: 16)),
            ),
          );
        },
      ),
    );
  }
}

// =======================================
// LAB 1 - DART BASICS
// =======================================

class Lab1Page extends StatelessWidget {
  const Lab1Page({super.key});

  List<String> runLab() {
    String studentName = 'Ahmad';
    int age = 22;
    int semester = 5;
    double gpa = 3.7;
    bool isActive = true;

    // Type inference
    var university = 'Kabul University';
    var totalCredits = 120;

    // Arithmetic operators
    int addition = age + semester;
    int subtraction = age - semester;
    int multiplication = age * semester;
    double division = age / semester;

    // Comparison operators
    bool isAdult = age >= 18;
    bool goodGpa = gpa >= 3.0;

    // Logical operators
    bool eligible = isAdult && goodGpa;
    bool activeOrExcellent = isActive || gpa >= 3.8;

    final results = [
      'Student Name: $studentName',
      'Age: $age',
      'Semester: $semester',
      'GPA: $gpa',
      'Active: $isActive',
      'University: $university',
      'Total Credits: $totalCredits',
      'Inferred university type: ${university.runtimeType}',
      'Inferred totalCredits type: ${totalCredits.runtimeType}',
      'Addition: $addition',
      'Subtraction: $subtraction',
      'Multiplication: $multiplication',
      'Division: ${division.toStringAsFixed(2)}',
      'Age >= 18: $isAdult',
      'GPA >= 3.0: $goodGpa',
      'Eligible (AND): $eligible',
      'Active or Excellent (OR): $activeOrExcellent',
    ];

    for (final result in results) {
      debugPrint(result);
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return ResultPage(title: 'Lab 1 - Dart Basics', results: runLab());
  }
}

// =======================================
// LAB 2 - CONDITIONS AND LOOPS
// =======================================

class Lab2Page extends StatefulWidget {
  const Lab2Page({super.key});

  @override
  State<Lab2Page> createState() => _Lab2PageState();
}

class _Lab2PageState extends State<Lab2Page> {
  final TextEditingController markController = TextEditingController(
    text: '85',
  );

  List<String> results = [];

  void calculate() {
    final mark = int.tryParse(markController.text);

    if (mark == null || mark < 0 || mark > 100) {
      setState(() {
        results = ['Enter a valid mark from 0 to 100.'];
      });
      return;
    }

    String grade;

    if (mark >= 90) {
      grade = 'A';
    } else if (mark >= 80) {
      grade = 'B';
    } else if (mark >= 70) {
      grade = 'C';
    } else if (mark >= 60) {
      grade = 'D';
    } else {
      grade = 'F';
    }

    String status = mark >= 60 ? 'Pass' : 'Fail';

    List<String> output = [
      'Mark: $mark',
      'Grade: $grade',
      'Status: $status',
      'Numbers from 1 to 20:',
    ];

    // FOR LOOP
    for (int i = 1; i <= 20; i++) {
      output.add('$i');
    }

    output.add('Even numbers:');

    // EVEN NUMBERS
    for (int i = 1; i <= 20; i++) {
      if (i % 2 == 0) {
        output.add('$i');
      }
    }

    output.add('While loop from 1 to 5:');

    // WHILE LOOP
    int number = 1;

    while (number <= 5) {
      output.add('While: $number');
      number++;
    }

    for (final line in output) {
      debugPrint(line);
    }

    setState(() {
      results = output;
    });
  }

  @override
  void dispose() {
    markController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 2 - Conditions & Loops')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: markController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Mark (0-100)',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(onPressed: calculate, child: const Text('Calculate')),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(results[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =======================================
// LAB 3 - LISTS
// =======================================

class Lab3Page extends StatelessWidget {
  const Lab3Page({super.key});

  List<String> runLab() {
    List<String> courses = [
      'Flutter',
      'Dart',
      'Database',
      'Software Engineering',
      'Networking',
    ];

    final results = <String>[];

    results.add('Original Courses: $courses');
    results.add('First Course: ${courses.first}');
    results.add('Last Course: ${courses.last}');

    // Add new course
    courses.add('Artificial Intelligence');
    results.add('After Adding AI: $courses');

    // Remove course
    courses.remove('Networking');
    results.add('After Removing Networking: $courses');

    // Check course
    bool hasFlutter = courses.contains('Flutter');
    results.add('Flutter Exists: $hasFlutter');

    // FOR-IN LOOP
    results.add('Course List:');

    for (final course in courses) {
      results.add(course);
    }

    // MARKS AVERAGE
    List<int> marks = [85, 90, 78, 88, 95];

    int total = 0;

    for (final mark in marks) {
      total += mark;
    }

    double average = total / marks.length;

    results.add('Marks: $marks');
    results.add('Total: $total');
    results.add('Average: ${average.toStringAsFixed(2)}');

    for (final result in results) {
      debugPrint(result);
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return ResultPage(title: 'Lab 3 - Lists', results: runLab());
  }
}

// =======================================
// LAB 4 - CLASSES AND CONSTRUCTORS
// =======================================

class Student {
  final String name;
  final String department;
  final int semester;

  Student({
    required this.name,
    required this.department,
    required this.semester,
  });

  String displayInfo() {
    return 'Name: $name\n'
        'Department: $department\n'
        'Semester: $semester';
  }
}

class Lab4Page extends StatelessWidget {
  const Lab4Page({super.key});

  List<String> runLab() {
    Student student1 = Student(
      name: 'Ahmad',
      department: 'Computer Science',
      semester: 5,
    );

    Student student2 = Student(
      name: 'Karim',
      department: 'Software Engineering',
      semester: 6,
    );

    Student student3 = Student(
      name: 'Ali',
      department: 'Information Technology',
      semester: 4,
    );

    List<Student> students = [student1, student2, student3];

    List<String> results = [];

    for (final student in students) {
      results.add(student.displayInfo());
      debugPrint(student.displayInfo());
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return ResultPage(title: 'Lab 4 - Classes', results: runLab());
  }
}
