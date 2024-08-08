import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaghetti/alarm.dart';
import 'package:spaghetti/homeAlert.dart';
import 'package:spaghetti/sensorService.dart';

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
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SensorService>(
      builder: (context, sensorService, child) {
        List<SensorData> senserList = sensorService.senserList;
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
                    Text(
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
                          sensorService.emarhencyState();
                          temp = 1;
                        });
                      },
                      child: temp == 0
                          ? Image.asset(
                              'assets/images/check.png',
                              width: screenWidth * 0.1,
                              height: screenWidth * 0.1,
                            )
                          : Image.asset(
                              'assets/images/exclamation_mark.png',
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
                      height: 2,
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
                      itemCount: senserList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            (screenWidth / 3) / (screenHeight * 0.15),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        SensorData sensor = senserList[index];

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
                              borderRadius: BorderRadius.circular(12),
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
                                      sensor.sensorImage,
                                      width: screenWidth * 0.1,
                                      height: screenWidth * 0.1,
                                    ),
                                    SizedBox(width: screenWidth * 0.15),
                                    Text(sensor.name)
                                  ],
                                ),
                                SizedBox(height: screenWidth * 0.05),
                                Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.025),
                                    Expanded(
                                      child: Text(sensor.date,
                                          style: TextStyle(color: Colors.grey)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: screenWidth * 0.025),
                                    Expanded(
                                      child: Text(sensor.detailText),
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
