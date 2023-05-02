import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schulplaner App',
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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Kalendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Aufgaben',
            ),
          ],
        ),
        body: Column(
          children: [
            Text(
              "Willkommen in der Schulplaner App!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 200,
                    color: Colors.purple[600],
                    child: const Center(
                        child: Text(
                      'Item 1',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 200,
                    color: Colors.purple[500],
                    child: const Center(
                        child: Text(
                      'Item 2',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 200,
                    color: Colors.purple[400],
                    child: const Center(
                        child: Text(
                      'Item 3',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  Container(
                    width: 200,
                    color: Colors.purple[300],
                    child: const Center(
                        child: Text(
                      'Item 4',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 500,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  _navigateToNextScreen(context);
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ));
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EventPage()));
  }
}

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  DateTime? _chosenDateTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController describController = TextEditingController();
  TextEditingController textControllerDate = TextEditingController();

  void _showDatePicker(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        dateOrder: DatePickerDateOrder.dmy,
                        use24hFormat: true,
                        onDateTimeChanged: (val) {
                          setState(() {
                            _chosenDateTime = val;
                          });
                        }),
                  ),
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    titleController.dispose();
    describController.dispose();
    textControllerDate.dispose();
    super.dispose();
  }

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
                  controller: titleController,
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
                controller: describController,
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
              Row(children: [
                Text(
                  _chosenDateTime != null
                      ? _chosenDateTime.toString()
                      : 'Wählen Sie das Datum aus!',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  onPressed: () => _showDatePicker(context),
                  icon: const Icon(Icons.calendar_month),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  CollectionReference collRef =
                      FirebaseFirestore.instance.collection("event");
                  collRef.add({
                    'Title': titleController.text,
                    'Description': describController.text,
                    'Date&Time': textControllerDate.text,
                  });
                },
                child: Text('Speichern'),
                style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
