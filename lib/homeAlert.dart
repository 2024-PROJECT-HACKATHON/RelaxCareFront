import 'package:flutter/material.dart';

class HomeAlert extends StatefulWidget {
  const HomeAlert({super.key});

  @override
  State<HomeAlert> createState() => _HomeAlert();
}

class _HomeAlert extends State<HomeAlert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Text("test"),
      ),
    );
  }
}
