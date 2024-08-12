import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaghetti/alarm.dart';
import 'package:spaghetti/homeAlert.dart';
import 'package:spaghetti/sensorService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'senserDetail.dart';

class MainListPage extends StatefulWidget {
  const MainListPage({super.key});

  @override
  State<MainListPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainListPage> {
  ScrollController? _scrollController;
  int temp = 0;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    fetchLdrData();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  Future<void> fetchLdrData() async {
    final url = 'http://125.176.199.86:8080/api/ldr-data/latest';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          var data = json.decode(utf8.decode(response.bodyBytes));
          print(" test: $data");
          Provider.of<SensorService>(context, listen: false)
              .sensorList
              .add(SensorData.fromJson(data));
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SensorService>(
      builder: (context, sensorService, child) {
        List<SensorData> sensorList = sensorService.sensorList;
        sensorService.imageMatching();
        sensorService.timechange();
        sensorService.detectIssueLevel();
        final mediaQuery = MediaQuery.of(context);
        final screenHeight = mediaQuery.size.height;
        final screenWidth = mediaQuery.size.width;

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(60.0),
                            ),
                          ),
                          builder: (context) => HomeAlert(),
                        );
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.03,
                          ),
                          Text(
                            '서울집',
                            style: TextStyle(
                              fontSize: screenWidth * 0.07,
                              color: Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.grey,
                            size: screenHeight * 0.05,
                            weight: screenWidth * 0.08,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Alarm(),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.notifications_none,
                                size: 35,
                              ),
                            ),
                            Positioned(
                              // 알림 위치인데 만약 위치가 폰마다 안맞을경우 right top을 0으로 설정 ㄱㄱ
                              right: 1,
                              top: 2,
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                child: Center(
                                  child: Text(
                                    '1', //여기서 알림개수
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: screenWidth * 0.03,
                        ),
                        Image.asset(
                          'assets/images/profil1.png',
                          width: screenWidth * 0.1,
                          height: screenWidth * 0.1,
                        ),
                        SizedBox(
                          width: screenWidth * 0.1,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.075,
                    ),
                    sensorService.detect
                        ? Text(
                            '  위험을 감지했습니다',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        : Text(
                            '오늘도 건강하게 하루를 \n보내고 계십니다',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                    SizedBox(
                      width: screenWidth * 0.3,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sensorService.setDetect(false);
                          print(sensorService.detect);
                        });
                      },
                      child: sensorService.detect
                          ? Image.asset(
                              'assets/images/exclamation_mark.png',
                              width: screenWidth * 0.1,
                              height: screenWidth * 0.1,
                            )
                          : Image.asset(
                              'assets/images/check.png',
                              width: screenWidth * 0.1,
                              height: screenWidth * 0.1,
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.075,
                    ),
                    Container(
                      height: 1,
                      width: screenWidth * 0.85,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.075),
                    child: GridView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.zero,
                      itemCount: sensorList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            (screenWidth / 3) / (screenHeight * 0.16),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        SensorData sensor = sensorList[index];

                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(60.0),
                                ),
                              ),
                              builder: (context) =>
                                  SensorDetail(sensor: sensor),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: sensor.issueLevel == 0
                                  ? Colors.white
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: screenWidth * 0.025),
                                Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.025),
                                    Image.asset(
                                      sensor.image,
                                      width: screenWidth * 0.1,
                                      height: screenWidth * 0.13,
                                    ),
                                    SizedBox(width: screenWidth * 0.15),
                                    Text(
                                      sensor.sensorName,
                                      style: sensor.issueLevel == 1
                                          ? TextStyle(color: Colors.white)
                                          : TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(height: screenWidth * 0.13),
                                Row(
                                  // 기기 정보 및 상태 표시
                                  children: [
                                    SizedBox(width: screenWidth * 0.025),
                                    Expanded(
                                      child: Text(sensor.timeStamp,
                                          style: TextStyle(color: Colors.grey)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.025),
                                    Expanded(
                                      child: Text(sensor.value ?? ""),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
