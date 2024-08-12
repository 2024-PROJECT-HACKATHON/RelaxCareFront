import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LdrDataPage extends StatefulWidget {
  @override
  _LdrDataPageState createState() => _LdrDataPageState();
}

class _LdrDataPageState extends State<LdrDataPage> {
  List<dynamic> ldrDataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLdrData();
  }

  Future<void> fetchLdrData() async {
    final url = 'http://192.168.0.2:8080/api/ldr-data';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          ldrDataList = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LDR Data'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ldrDataList.length,
              itemBuilder: (context, index) {
                final ldrData = ldrDataList.reversed.toList()[index];
                return ListTile(
                  title: Text('LDR Value: ${ldrData['ldrValue']}'),
                  subtitle: Text('Timestamp: ${ldrData['timestamp']}'),
                );
              },
            ),
    );
  }
}
