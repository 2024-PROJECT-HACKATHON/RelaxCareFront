import 'package:flutter/material.dart';
import 'package:spaghetti/sensorService.dart';

import 'emargencyDialog.dart'; // SensorData 클래스가 정의된 파일을 임포트합니다.

class SensorDetail extends StatefulWidget {
  final SensorData sensor;

  SensorDetail({required this.sensor});

  @override
  _SensorDetail createState() => _SensorDetail();
}

class _SensorDetail extends State<SensorDetail> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Row(
            children: [
              SizedBox(width: screenWidth * 0.02),
              Image.asset(
                widget.sensor.sensorImage,
                width: screenWidth * 0.1,
                height: screenWidth * 0.1,
              ),
              SizedBox(width: screenWidth * 0.3),
              Expanded(
                child: Text(
                  widget.sensor.date,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              if (widget.sensor.issueLevel == 0)
                Image.asset(
                  'assets/images/check.png',
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                )
              else
                Image.asset(
                  'assets/images/exclamation_mark.png',
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                ),
              SizedBox(width: screenWidth * 0.02),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Row(
            children: [
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: Text(
                  widget.sensor.detailText,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Container(
                height: 2,
                width: screenWidth * 0.85,
                color: Colors.black,
              ),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Text("장치 이름",
                  style: TextStyle(fontSize: 15, color: Colors.black)),
              Expanded(
                child: Text(widget.sensor.sensorName + '  >',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 15, color: Colors.grey)),
              ),
              SizedBox(width: screenWidth * 0.02),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Row(
            children: [
              SizedBox(width: screenWidth * 0.02),
              Text(
                "연결 네트워크",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              Expanded(
                child: Text(
                  widget.sensor.sensorNetwork,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
            ],
          ),
          SizedBox(
            height: screenHeight * 0.02,
          ),
          Row(
            children: [
              SizedBox(width: screenWidth * 0.02),
              Text(
                "신호 강도",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              Expanded(
                child: Text(
                  widget.sensor.signalPower,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
            ],
          ),
          if (widget.sensor.issueLevel == 0)
            SizedBox(
              height: screenWidth * 0.3,
            )
          else
            Column(
              children: [
                SizedBox(
                  height: screenWidth * 0.1,
                ),
                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.02),
                    SizedBox(
                      width: screenWidth * 0.86,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white10,
                          foregroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "경고 확인",
                          style: TextStyle(
                              fontFamily: 'NanumB',
                              color: Colors.red,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenWidth * 0.04,
                ),
                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.02),
                    SizedBox(
                      width: screenWidth * 0.86,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EmergencyDialog(); // EmergencyDialog 사용
                            },
                          );
                        },
                        child: Text(
                          "응급 신고",
                          style: TextStyle(
                              fontFamily: 'NanumB',
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
