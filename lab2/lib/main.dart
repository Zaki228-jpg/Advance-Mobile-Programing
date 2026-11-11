import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const Week2App());
}

// ======================================
// MAIN APP AND GLOBAL THEME
// ======================================

class Week2App extends StatelessWidget {
  const Week2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Week 2 Labs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

// ======================================
// HOME PAGE
// ======================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Mobile Programming')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.flutter_dash, size: 90, color: Colors.indigo),
              const SizedBox(height: 15),
              Text(
                'Flutter Week 2',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 10),
              const Text('Four Practical Labs'),
              const SizedBox(height: 30),

              labButton(context, 'Lab 1 - Hello World', const HelloWorldPage()),
              labButton(context, 'Lab 2 - Hot Reload', const CounterPage()),
              labButton(context, 'Lab 3 - Theme', const ThemePage()),
              labButton(
                context,
                'Lab 4 - External Package',
                const PackagePage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget labButton(BuildContext context, String title, Widget page) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: SizedBox(
        width: 300,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => page));
          },
          child: Text(title),
        ),
      ),
    );
  }
}

// ======================================
// LAB 1 - HELLO WORLD
// ======================================

class HelloWorldPage extends StatelessWidget {
  const HelloWorldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 1 - Hello World')),
      body: const Center(
        child: Text(
          'Hello World!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }
}

// ======================================
// LAB 2 - HOT RELOAD AND COUNTER
// ======================================

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    debugPrint('Counter initialized');
  }

  void increaseCounter() {
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
    debugPrint('Counter screen rebuilt');

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 2 - Hot Reload')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter Value:', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 15),

            Text(
              '$counter',
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: increaseCounter,
              child: const Text('Increase Counter'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: resetCounter,
              child: const Text('Reset Counter'),
            ),

            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Hot Reload: Usually preserves state.\n'
                'Hot Restart: Resets application state.\n'
                'Full Restart: Restarts the application process.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================
// LAB 3 - GLOBAL AND LOCAL THEME
// ======================================

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final globalTheme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 3 - Theme')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Global Theme', style: globalTheme.textTheme.headlineMedium),

              const SizedBox(height: 15),

              Text(
                'This text uses the global theme.',
                style: globalTheme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {},
                child: const Text('Global Button'),
              ),

              const SizedBox(height: 35),

              // LOCAL THEME OVERRIDE
              Theme(
                data: globalTheme.copyWith(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                child: Builder(
                  builder: (localContext) {
                    final localTheme = Theme.of(localContext);

                    return Column(
                      children: [
                        Text(
                          'Local Theme',
                          style: localTheme.textTheme.headlineMedium?.copyWith(
                            color: localTheme.colorScheme.primary,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          'This section uses an orange theme.',
                          style: localTheme.textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 15),

                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Local Button'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ======================================
// LAB 4 - EXTERNAL PACKAGE (INTL)
// ======================================

class PackagePage extends StatefulWidget {
  const PackagePage({super.key});

  @override
  State<PackagePage> createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  DateTime selectedDate = DateTime.now();

  Future<void> chooseDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null && mounted) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat(
      'EEEE, MMMM d, yyyy',
      'en_US',
    ).format(selectedDate);

    final formattedNumber = NumberFormat.decimalPattern('en_US')
        .format(1234567);

    return Scaffold(
      appBar: AppBar(title: const Text('Lab 4 - External Package')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_month, size: 80, color: Colors.indigo),

              const SizedBox(height: 20),

              Text(
                'Flutter intl Package',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              const Text('Formatted Date:', style: TextStyle(fontSize: 18)),

              const SizedBox(height: 10),

              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: chooseDate,
                child: const Text('Choose Date'),
              ),

              const SizedBox(height: 30),

              const Text('Formatted Number:', style: TextStyle(fontSize: 18)),

              const SizedBox(height: 10),

              Text(
                formattedNumber,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Package: intl\n'
                'Purpose: Date and number formatting\n'
                'Platforms: Android, iOS, Web, Desktop',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
