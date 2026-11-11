import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const AdvancedMobileProgrammingApp());
}

class AdvancedMobileProgrammingApp extends StatelessWidget {
  const AdvancedMobileProgrammingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Mobile Programming',

      // Global Theme
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),

      home: const HomeScreen(),
    );
  }
}

// StatefulWidget for the counter interaction
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Mobile Programming'),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.phone_android,
                size: 80,
              ),

              const SizedBox(height: 24),

              Text(
                'Advanced Mobile Programming',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.code),
                        title: Text('Course Code'),
                        subtitle: Text('AMP-401'),
                      ),
                      ListTile(
                        leading: Icon(Icons.school),
                        title: Text('Semester'),
                        subtitle: Text('6th Semester'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                'Counter: $counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: incrementCounter,
                    child: const Icon(Icons.add),
                  ),

                  const SizedBox(width: 16),

                  OutlinedButton(
                    onPressed: resetCounter,
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}