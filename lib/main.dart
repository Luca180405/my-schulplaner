import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: const Center(
          child: Text(
        'Wilkommen in der Schulplaner App!',
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToNextScreen(context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EventScreen()));
  }
}

class EventScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ereignis adden')),
      body: const Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter the title',
            ),
          ),
          
        ),
      ),
    );
  }
}
