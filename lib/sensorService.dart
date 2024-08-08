import 'package:flutter/material.dart';
import 'main.dart';

class SensorData {
  String name;
  String date;
  String detailText;
  String sensorImage;
  String sensorName;
  String sensorNetwork;
  String signalPower;
  int issueLevel;

  SensorData({
    required this.name,
    required this.date,
    required this.detailText,
    required this.sensorImage,
    required this.sensorName,
    required this.sensorNetwork,
    required this.signalPower,
    required this.issueLevel,
  });
}

class SensorService extends ChangeNotifier {
  List<SensorData> senserList = [
    SensorData(
        name: "소리",
        date: "10초 전 감지",
        detailText: "노래를 듣고 있으세요",
        sensorImage: "assets/images/sound.png",
        sensorName: "소리감지기",
        sensorNetwork: "Iptime 2.4",
        signalPower: "-54dbm",
        issueLevel: 0),
    SensorData(
        name: "가스",
        date: "1시간 전 마지막 감지",
        detailText: "가스가 잘 잠겨 있어요",
        sensorImage: "assets/images/gas.png",
        sensorName: "가스감지기",
        sensorNetwork: "Iptime 2.4",
        signalPower: "-54dbm",
        issueLevel: 0),
    SensorData(
        name: "온도",
        date: "24'C",
        detailText: "아주 퀘적한 온도 입니다",
        sensorImage: "assets/images/thermometer.png",
        sensorName: "온도계",
        sensorNetwork: "Iptime 2.4",
        signalPower: "-54dbm",
        issueLevel: 0),
    SensorData(
        name: "동작",
        date: "11시간전 감지",
        detailText: "열심히 활동하고 있으세요",
        sensorImage: "assets/images/move.png",
        sensorName: "거실 동작 감지기",
        sensorNetwork: "Iptime 2.4",
        signalPower: "-54dbm",
        issueLevel: 0),
    SensorData(
        name: "창문",
        date: "3시간 전 감지",
        detailText: "잘 닫혀 있어요",
        sensorImage: "assets/images/window.png",
        sensorName: "창문개폐감지기",
        sensorNetwork: "Iptime 2.4",
        signalPower: "-54dbm",
        issueLevel: 0),
  ];

  void emarhencyState() {
    senserList[3].date = "12시간전 동작";
    senserList[3].detailText = "특이사항 발생";
    senserList[3].issueLevel = 1;
    notifyListeners();
  }
}
