import 'package:flutter/cupertino.dart';
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
        body: Column(
          children: [
            Text("Willkommen in der Schulplaner App"),
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
              height: 620,
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

                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
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
                onPressed: () {},
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
