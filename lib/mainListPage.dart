import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaghetti/sensorService.dart';

class MainListPage extends StatefulWidget {
  const MainListPage({super.key});

  @override
  State<MainListPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainListPage> {
  ScrollController? _scrollController;

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
    return Consumer<SensorService>(builder: (context, sensorService, child) {
      List<SensorData> senserList = sensorService.senserList;

      final mediaQuery = MediaQuery.of(context);
      final screenHeight = mediaQuery.size.height;
      final screenWidth = mediaQuery.size.width;

      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.075,
            ),
            Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.075,
                ),
                Text('서울집', style: TextStyle(fontSize: screenWidth * 0.07)),
                SizedBox(
                  width: screenWidth * 0.4,
                ),
                Image.asset(
                  'assets/images/signal.png',
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                ),
                SizedBox(
                  width: screenWidth * 0.05,
                ),
                Image.asset(
                  'assets/images/profil1.png',
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.075,
                ),
                Text(
                  '오늘도 건강하게 하루를 \n보내고 계십니다',
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
                SizedBox(
                  width: screenWidth * 0.3,
                ),
                Image.asset(
                  'assets/images/check.png',
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
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
                  height: 3,
                  width: screenWidth * 0.85,
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.075),
                child: GridView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  itemCount: senserList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (screenWidth / 3) / (screenHeight * 0.15),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    SensorData sensor = senserList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                          SizedBox(
                            height: screenWidth * 0.025,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.025,
                              ),
                              Image.asset(
                                sensor.sensorImage,
                                width: screenWidth * 0.1,
                                height: screenWidth * 0.1,
                              ),
                              SizedBox(
                                width: screenWidth * 0.15,
                              ),
                              Text(sensor.name)
                            ],
                          ),
                          SizedBox(
                            height: screenWidth * 0.05,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.025,
                              ),
                              Expanded(
                                child: Text(sensor.date,
                                    style: TextStyle(color: Colors.grey)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.025,
                              ),
                              Expanded(
                                child: Text(
                                  sensor.detailText,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
