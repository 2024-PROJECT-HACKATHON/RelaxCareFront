import 'package:flutter/material.dart';
import 'main.dart';

class SensorData {
  String name;
  String date;
  String detailText;
  SensorData({
    required this.name,
    required this.date,
    required this.detailText,
  });
}

class SensorService extends ChangeNotifier {
  List<SensorData> senserList = [
    SensorData(name: "소리", date: "10초 전 감지", detailText: "노래를 듣고 있으세요"),
    SensorData(name: "가스", date: "1시간 전 마지막 감지", detailText: "가스가 잘 잠겨 있어요"),
    SensorData(name: "온도", date: "24'C", detailText: "아주 퀘적한 온도 입니다"),
    SensorData(name: "동작", date: "30초 전 감지", detailText: "열심히 활동하고 있으세요"),
    SensorData(name: "창문", date: "3시간 전 감지", detailText: "잘 닫혀 있어요"),
  ];
}
