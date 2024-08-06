import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaghetti/mainListPage.dart';
import 'package:spaghetti/sensorService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SensorService()),
      ],
      child: MaterialApp(
        home: MainListPage(),
      ),
    );
  }
}
