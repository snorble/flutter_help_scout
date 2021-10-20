import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_help_scout/flutter_help_scout.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help Scout Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // create an instance of Flutter Help Scout and pass the beacon ID and other values to it
  late FlutterHelpScout _beacon;
  String beaconId = '';

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBeacon() async {
    _beacon = FlutterHelpScout(
        beaconId: beaconId,
        email: 'example@example.com',
        name: 'John Doe',
        avatar:
            'https://privilee-avatar.imgix.net/dace837051aa/d37e4306-f3d9-44e9-9257-1e6ab34ea10f/original.png');

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _beacon.initialize();
    } on PlatformException catch (e) {
      debugPrint('${e.message}');
    }
  }

  @override
  void initState() {
    // initialize beacon
    initBeacon();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Scott Example'),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: RaisedButton(
        child: Text(
          'Open Beacon',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blue,
        onPressed: () {
          _beacon.openContact(beaconId);
        },
      )),
    );
  }
}
