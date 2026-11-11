import 'package:flutter/material.dart';

void main() {
  runApp(const NavigationLabsApp());
}

// ======================================
// MAIN APPLICATION
// ======================================

class NavigationLabsApp extends StatelessWidget {
  const NavigationLabsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation & Routing Labs',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const MainHomePage(),
    );
  }
}

// ======================================
// MAIN HOME PAGE
// ======================================

class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final labs = [
      ('Lab 1 - Stack Navigation', Icons.layers, const StackNavigationHome()),
      ('Lab 2 - Passing Data', Icons.shopping_bag, const ProductListPage()),
      (
        'Lab 3 - Returning Result',
        Icons.assignment_return,
        const DepartmentHomePage(),
      ),
      ('Lab 4 - Drawer', Icons.menu, const DrawerHomePage()),
      ('Lab 5 - Tabs', Icons.tab, const CoursesTabPage()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecture 8 - Navigation'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
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
          const Text(
            'Five Practical Navigation Labs',
            textAlign: TextAlign.center,
          ),
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

// ======================================
// LAB 1 - STACK NAVIGATION
// ======================================

class StackNavigationHome extends StatelessWidget {
  const StackNavigationHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 1 - Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StackNavigationDetails()),
            );
          },
          child: const Text('Open Details Page'),
        ),
      ),
    );
  }
}

class StackNavigationDetails extends StatelessWidget {
  const StackNavigationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back to Home'),
        ),
      ),
    );
  }
}

// ======================================
// LAB 2 - PASSING DATA
// ======================================

class Product {
  final int id;
  final String name;
  final double price;

  const Product({required this.id, required this.name, required this.price});
}

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  static const products = [
    Product(id: 1, name: 'Laptop', price: 850),
    Product(id: 2, name: 'Smartphone', price: 450),
    Product(id: 3, name: 'Headphones', price: 75),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 2 - Products')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            child: ListTile(
              leading: const Icon(Icons.shopping_bag, color: Colors.indigo),
              title: Text(product.name),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailsPage(
                      productId: product.id,
                      productName: product.name,
                      productPrice: product.price,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final int productId;
  final String productName;
  final double productPrice;

  const ProductDetailsPage({
    super.key,
    required this.productId,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart, size: 90, color: Colors.indigo),
            const SizedBox(height: 20),
            Text(
              'Product ID: $productId',
              style: const TextStyle(fontSize: 20),
            ),
            Text('Name: $productName', style: const TextStyle(fontSize: 22)),
            Text(
              'Price: \$${productPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================
// LAB 3 - RETURNING A RESULT
// ======================================

class DepartmentHomePage extends StatefulWidget {
  const DepartmentHomePage({super.key});

  @override
  State<DepartmentHomePage> createState() => _DepartmentHomePageState();
}

class _DepartmentHomePageState extends State<DepartmentHomePage> {
  String selectedDepartment = 'None selected';

  Future<void> selectDepartment() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const SelectDepartmentPage()),
    );

    if (!mounted) return;

    setState(() {
      selectedDepartment = result ?? 'No department selected';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 3 - Return Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Department:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 15),
            Text(
              selectedDepartment,
              style: const TextStyle(fontSize: 23, color: Colors.indigo),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: selectDepartment,
              child: const Text('Select Department'),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectDepartmentPage extends StatelessWidget {
  const SelectDepartmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    const departments = [
      'Computer Science',
      'Software Engineering',
      'Information Technology',
      'Business Administration',
      'Economics',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Select Department')),
      body: ListView(
        children: [
          for (final department in departments)
            ListTile(
              leading: const Icon(Icons.school),
              title: Text(department),
              onTap: () {
                Navigator.pop(context, department);
              },
            ),
        ],
      ),
    );
  }
}

// ======================================
// LAB 4 - DRAWER NAVIGATION
// ======================================

class DrawerHomePage extends StatelessWidget {
  const DrawerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DrawerScaffold(
      title: 'Drawer Home',
      child: Center(
        child: Text('Welcome to Drawer Home', style: TextStyle(fontSize: 22)),
      ),
    );
  }
}

class DrawerProfilePage extends StatelessWidget {
  const DrawerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DrawerScaffold(
      title: 'Profile',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 45, child: Icon(Icons.person, size: 50)),
            SizedBox(height: 15),
            Text('Student Profile', style: TextStyle(fontSize: 23)),
          ],
        ),
      ),
    );
  }
}

class DrawerSettingsPage extends StatelessWidget {
  const DrawerSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DrawerScaffold(
      title: 'Settings',
      child: Center(
        child: Text('Application Settings', style: TextStyle(fontSize: 22)),
      ),
    );
  }
}

class DrawerScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const DrawerScaffold({super.key, required this.title, required this.child});

  void openPage(BuildContext context, Widget page) {
    // Close the drawer first.
    Navigator.pop(context);

    // Navigate after the drawer closes.
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Flutter Student'),
              accountEmail: Text('Advanced Mobile Programming'),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person, size: 40),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                openPage(context, const DrawerHomePage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                openPage(context, const DrawerProfilePage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                openPage(context, const DrawerSettingsPage());
              },
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}

// ======================================
// LAB 5 - TABS
// ======================================

class Course {
  final String name;
  final String status;

  const Course(this.name, this.status);
}

class CoursesTabPage extends StatelessWidget {
  const CoursesTabPage({super.key});

  static const courses = [
    Course('Flutter Development', 'Active'),
    Course('Dart Programming', 'Completed'),
    Course('Mobile UI Design', 'Active'),
    Course('Software Engineering', 'Completed'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lab 5 - Course Tabs'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'All'),
              Tab(icon: Icon(Icons.play_circle), text: 'Active'),
              Tab(icon: Icon(Icons.check_circle), text: 'Completed'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CourseList(filter: 'All'),
            CourseList(filter: 'Active'),
            CourseList(filter: 'Completed'),
          ],
        ),
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  final String filter;

  const CourseList({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    final filteredCourses = CoursesTabPage.courses.where((course) {
      return filter == 'All' || course.status == filter;
    }).toList();

    return ListView.builder(
      itemCount: filteredCourses.length,
      itemBuilder: (context, index) {
        final course = filteredCourses[index];

        return Card(
          child: ListTile(
            leading: const Icon(Icons.book, color: Colors.indigo),
            title: Text(course.name),
            subtitle: Text(course.status),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CourseDetailsPage(course: course),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class CourseDetailsPage extends StatelessWidget {
  final Course course;

  const CourseDetailsPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Course Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.menu_book, size: 85, color: Colors.indigo),
            const SizedBox(height: 20),
            Text(course.name, style: const TextStyle(fontSize: 25)),
            const SizedBox(height: 10),
            Text(
              'Status: ${course.status}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Courses'),
            ),
          ],
        ),
      ),
    );
  }
}
