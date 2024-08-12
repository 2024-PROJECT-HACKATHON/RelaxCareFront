import 'package:flutter/material.dart';
import 'main.dart';

class SensorData {
  String sensorName;
  String? value;
  String timeStamp;
  String ssId;
  int signalPower;
  int issueLevel;
  late String image;

  SensorData(
    this.sensorName,
    this.value,
    this.timeStamp,
    this.ssId,
    this.signalPower,
    this.issueLevel,
  );

  factory SensorData.fromJson(Map<String, dynamic> jsonData) {
    return SensorData(
        jsonData['sensorName'] ?? "",
        jsonData['value']?.toString() ?? "",
        jsonData['timeStamp'] ?? "",
        jsonData["ssId"] ?? "",
        jsonData['signalPower'] ?? 0,
        jsonData['issueLevel']);
  }
}

class SensorService extends ChangeNotifier {
  List<SensorData> sensorList = [
    SensorData("소리", "25db", "2024-08-13T03:25:53", "Iptime 2.4", -54, 0),
    SensorData("가스", "25ppm?", "2024-08-13T03:25:53", "Iptime 2.4", -54, 0),
    SensorData("온도", "24'C", "2024-08-13T03:25:53", "Iptime 2.4", -54, 0),
    SensorData("창문", "close", "2024-08-13T03:25:53", "Iptime 2.4", -54, 0),
  ];
  bool detect = false;

  //감지
  void detectIssueLevel() {
    for (int i = 0; i < sensorList.length; i++) {
      if (sensorList[i].issueLevel == 1) {
        detect = true;
      }
    }
  }

  //이미지 맞춰주기
  void imageMatching() {
    for (int i = 0; i < sensorList.length; i++) {
      switch (sensorList[i].sensorName) {
        case "소리":
          sensorList[i].image = "assets/images/sound.png";
          break;
        case "가스":
          sensorList[i].image = "assets/images/gas.png";
          break;
        case "온도":
          sensorList[i].image = "assets/images/thermometer.png";
          break;
        case "조도":
          sensorList[i].image = "assets/images/Illuminance.png";
          break;
        case "창문":
          sensorList[i].image = "assets/images/window.png";
          break;
        default:
          break;
      }
    }
  }

  //시간을 설명하는 로직 ex 몇분전 몇시간전
  void timechange() {
    for (int i = 0; i < sensorList.length; i++) {
      try {
        DateTime? sensorTime = DateTime.parse(sensorList[i].timeStamp);

        print(sensorTime);
        // 현재 시간을 가져오기
        DateTime now = DateTime.now().toUtc().add(Duration(hours: 9));

        // 현재 시간과 sensorTime 간의 차이 계산
        Duration difference = now.difference(sensorTime);

        // 차이를 분, 시간, 일로 계산
        int minutesDifference = difference.inMinutes;
        int hoursDifference = difference.inHours;
        int daysDifference = difference.inDays;

        String total = "";
        // 몇분전인지
        if (minutesDifference >= 0 && minutesDifference < 60) {
          total = '$minutesDifference분 전 감지';
        } else if (hoursDifference < 24 && hoursDifference > 0) {
          total = '$hoursDifference시간 전 감지';
        } else {
          total = '$daysDifference일 전 감지';
        }
        sensorList[i].timeStamp = total;
        // notifyListeners();
      } catch (e) {
        print("Invalid date format: ${sensorList[i].timeStamp}");
        sensorList[i].timeStamp = "10시간 전 감지";
      }
    }
  }
}
