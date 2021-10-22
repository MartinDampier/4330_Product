import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Sound Trek',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: const Color.fromARGB(255, 98, 98, 98),
        primarySwatch: Colors.blue,
        canvasColor: Colors.grey,
      ),
      home: const MyHomePage(title: 'Welcome to Sound Trek'),
    );
  }
}

class MyHomePage extends StatefulWidget
{
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold
      (
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255,149, 215, 201),
        centerTitle: true,
        title: Text(widget.title, style: const TextStyle( color: Color.fromARGB(255, 98, 98, 98),)),
        leading: IconButton(
          icon: const ImageIcon(
            AssetImage('assets/logos/SoundTrek_Simplified.png'),
            size: 300,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),

      drawer: const Drawer(
        child: Text('Hello'),
      ),

      body: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: _goToTheLake,
        child: const Icon(Icons.menu, color: Color.fromARGB(255, 98, 98, 98)),
        backgroundColor: const Color.fromARGB(255,149, 215, 201),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

  }
}
