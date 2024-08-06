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
    return Consumer<SensorService>(
      builder: (context, sensorService, child) {
        List<SensorData> senserList = sensorService.senserList;

        final mediaQuery = MediaQuery.of(context);
        final screenHeight = mediaQuery.size.height;
        final screenWidth = mediaQuery.size.width;

        return Scaffold(
          body: SafeArea(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
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
                            Icons.arrow_downward_rounded,
                            color: Colors.black,
                            size: screenWidth * 0.08,
                            weight: screenWidth * 0.08,
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: screenWidth * 0.3,
                    // ),

                    // SizedBox(
                    //   width: screenWidth * 0.03,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/signal.png',
                          width: screenWidth * 0.1,
                          height: screenHeight * 0.1,
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
                  height: screenHeight * 0.04,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.075,
                    ),
                    Text('오늘도 건강하게 하루를 \n보내고 계십니다',
                        style: TextStyle(fontSize: screenWidth * 0.04)),
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
                      width: screenWidth * 0.8,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
