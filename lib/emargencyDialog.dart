import 'package:flutter/material.dart';

class EmergencyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                '119, 복지사에게 \n 자동으로 신고됩니다',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'NanumB',
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          SizedBox(
            width: screenWidth * 0.86,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // 응급 신호를 보내는 로직을 여기에 추가
                Navigator.of(context).pop(); // 팝업창 닫기
              },
              child: Text(
                '응급 신호',
                style: TextStyle(
                  fontFamily: 'NanumB',
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
