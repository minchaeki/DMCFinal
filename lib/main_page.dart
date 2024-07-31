import 'package:flutter/material.dart';
import 'home_page.dart';
import 'health_page.dart';
import 'report_page.dart';
import 'food_log_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // 현재 선택된 탭 인덱스
  final List<Widget> _pages = [
    const HomePage(),
    const HealthPage(),
    const FoodLogPage(), // 기록 페이지
    const ReportPage(
      result: {},
    ),
  ]; // 각 탭에 대응하는 페이지 위젯 목록

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // 현재 선택된 페이지 표시
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // 현재 선택된 탭 인덱스 설정
        onTap: (index) {
          setState(() {
            _currentIndex = index; // 탭 선택 시 인덱스 변경
          });
        },
        selectedItemColor: Colors.black, // 선택된 아이템 색상
        unselectedItemColor: Colors.black, // 선택되지 않은 아이템 색상
        selectedLabelStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold), // 선택된 라벨 스타일
        unselectedLabelStyle:
            const TextStyle(color: Colors.black), // 선택되지 않은 라벨 스타일
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // 홈 아이콘
            label: '홈', // 홈 라벨
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite), // 내 건강 아이콘
            label: '내 건강', // 내 건강 라벨
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant), // 기록 아이콘
            label: '기록', // 기록 라벨
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart), // 리포트 아이콘
            label: '리포트', // 리포트 라벨
          ),
        ],
      ),
    );
  }
}
