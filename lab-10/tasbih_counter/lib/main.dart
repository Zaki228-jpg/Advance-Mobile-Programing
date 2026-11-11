import 'package:flutter/material.dart';

void main() {
  runApp(const TasbihApp());
}

class TasbihApp extends StatelessWidget {
  const TasbihApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasbih Counter',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const TasbihScreen(),
    );
  }
}

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen> {
  int count = 0;
  int target = 33;

  void increaseCount() {
    if (count >= target) return;

    setState(() {
      count++;
    });

    if (count == target) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Target completed!')));
    }
  }

  void resetCount() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasbih Counter'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Subhanullah',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              Text(
                '$count / $target',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: [
                  for (final value in const [33, 99, 100])
                    ChoiceChip(
                      key: Key('target$value'),
                      label: Text('$value'),
                      selected: target == value,
                      onSelected: (_) {
                        setState(() {
                          target = value;
                          count = 0;
                        });
                      },
                    ),
                ],
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: 150,
                height: 150,
                child: ElevatedButton(
                  key: const Key('countButton'),
                  onPressed: increaseCount,
                  style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                  child: const Text(
                    'COUNT',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                key: const Key('resetButton'),
                onPressed: resetCount,
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
