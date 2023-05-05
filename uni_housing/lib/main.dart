import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'College Dorm Room Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Uni Housing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? location;
  double? mileRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter your location:',
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    location = value;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a location',
                ),
              ),
            ),
            const Text(
              'Select mile range:',
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<double>(
                value: mileRange,
                icon: const Icon(Icons.arrow_drop_down),
                onChanged: (double? newValue) {
                  setState(() {
                    mileRange = newValue;
                  });
                },
                items: <double>[5, 10, 15, 20, 25]
                    .map<DropdownMenuItem<double>>((double value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text('$value miles'),
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Add functionality to filter dorm rooms based on location and mile range.
              },
              child: const Text('Find a Dorm Room'),
            ),
          ],
        ),
      ),
    );
  }
}
