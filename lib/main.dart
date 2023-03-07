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
      appBar: AppBar(title: const Text('Ereignis hinzufügen')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Geben Sie den Titel ein',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Geben Sie die Beschreibung an',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Speichern'),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
