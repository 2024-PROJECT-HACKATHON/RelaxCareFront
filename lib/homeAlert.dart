import 'package:flutter/material.dart';

class HomeAlert extends StatefulWidget {
  const HomeAlert({super.key});

  @override
  State<HomeAlert> createState() => _HomeAlert();
}

class _HomeAlert extends State<HomeAlert> {
  List<String> temp = ["서울 집", "부산 집"];
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Container(
      padding: EdgeInsets.all(30.0),
      height: screenHeight * 0.47,
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(60.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Text(
            "홈",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          Divider(
            thickness: 3,
            color: Color(0xFFC0C0C0),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (BuildContext ctx, int index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.05,
                              ),
                              Text(
                                temp[index],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          Icon(Icons.check),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.05,
                  ),
                  Text(
                    "홈 설정",
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings_outlined,
                  size: 35,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
