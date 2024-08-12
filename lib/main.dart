import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaghetti/mainListPage.dart';
import 'package:spaghetti/sensorService.dart';
import 'package:spaghetti/ldr_data_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SensorService()),
      ],
      child: MaterialApp(
        home: LdrDataPage(),
        theme: ThemeData(
          fontFamily: 'NanumB',
          scaffoldBackgroundColor: Colors.white, // 전체 앱의 Scaffold 배경색을 흰색으로 설정
          dialogBackgroundColor: Colors.white, // 다이얼로그 배경색을 흰색으로 설정
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white, // AppBar 배경색을 흰색으로 설정
            iconTheme:
                IconThemeData(color: Colors.black), // AppBar 아이콘 색상을 검정으로 설정
            titleTextStyle: TextStyle(
              color: Colors.black, // AppBar 타이틀 텍스트 색상을 검정으로 설정
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'NanumB',
            ),
            elevation: 0, // AppBar 그림자 없애기
          ),
        ),
      ),
    );
  }
}
