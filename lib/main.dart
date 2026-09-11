import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const int myThreshold = 5;
const Color mySeedColor = Color.fromARGB(255, 70, 7, 188);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: mySeedColor,
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'MAD Lab Task 1 (The Counter App)',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  int _resetCount = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _resetCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Number Of Times You Pushed (+):',
            ),

            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            if (_counter > myThreshold)
              const Text(
                "You're on a roll!",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            
            if (_counter < myThreshold)
              const Text(
                "You're not on a roll!",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 15),

            Text(
              'Resets used: $_resetCount',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 30),

            const Text(
              'Built by Abdul Rehman Hassan (04072313030)',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _resetCounter,
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),

          const SizedBox(width: 15),

          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
