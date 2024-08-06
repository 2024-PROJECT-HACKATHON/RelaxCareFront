import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

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
        resizeToAvoidBottomInset: false, // 키보드 오버플로우 방지
        body: PageView(
          children: [
            Container(
              child: Stack(
                children: [
                  Positioned(
                    left: screenWidth * 0.13,
                    top: screenHeight * 0.11,
                    child: Image.asset(
                      'assets/images/profil1.png',
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.31,
                    top: screenHeight * 0.12,
                    child: Text('서울집',
                        style: TextStyle(fontSize: screenWidth * 0.04)),
                  ),
                  Positioned(
                    left: screenWidth * 0.31,
                    top: screenHeight * 0.15,
                    child: Text('님',
                        style: TextStyle(
                            fontSize: screenWidth * 0.03,
                            color: Color(0xff424141))),
                  ),
                  Positioned(
                    left: screenWidth * 0.12,
                    top: screenHeight * 0.23,
                    child: Text('오늘도 건강하게 하루를 보내고 계십니다',
                        style: TextStyle(fontSize: screenWidth * 0.05)),
                  ),
                  Positioned(
                    top: screenHeight * 0.23 + 30, // "이전 수업" 텍스트 아래 30px
                    left: screenWidth * 0.1,
                    child: SizedBox(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.45, // 목록을 위한 높이 조정
                      child: ListView.builder(
                        controller: _scrollController, // ScrollController 추가
                        padding: EdgeInsets.zero, // ListView의 패딩을 없앰
                        itemCount: senserList.length,
                        itemBuilder: (context, index) {
                          SensorData sensor = senserList[index];
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    // 작은 아이콘 추가
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              sensor.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16.0, // 텍스트 크기 설정
                                                fontWeight:
                                                    FontWeight.bold, // 폰트 굵기 설정
                                                color: Colors.black, // 폰트 색상 설정
                                                fontFamily:
                                                    'NanumB', // 폰트 패밀리 설정
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  Positioned(
                    left: screenWidth * 0.1,
                    bottom: screenHeight * 0.1 - 50, // 하단에서 50px 위로
                    child: SizedBox(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.06, // 화면 너비의 80%
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff789ad0),
                          surfaceTintColor: Color(0xff789ad0),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "수업 생성하기",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "+",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // logout 아이콘의 Positioned 위치
                  Positioned(
                    right: screenWidth * 0.1,
                    top: screenHeight * 0.12,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/images/logout.png', // 이미지 경로 확인
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                      ),
                      iconSize: screenWidth * 0.08,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              contentPadding: EdgeInsets.all(20),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '로그아웃 하시겠습니까?',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // 모달 닫기
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xfff7f8fc),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text('취소',
                                              style: TextStyle(
                                                  fontFamily: "NanumEB",
                                                  color: Color(0xff789bd0))),
                                        ),
                                      ),
                                      SizedBox(width: 10), // 버튼 사이 간격
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff789bd0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text('로그아웃',
                                              style: TextStyle(
                                                  fontFamily: "NanumEB",
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
