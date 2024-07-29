import 'package:flutter/material.dart';
import 'calendar_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedDay = 1; // 선택된 날
  final ScrollController _scrollController = ScrollController(); // 스크롤 컨트롤러
  final Map<int, Map<String, String>> _mealData = {
    1: {
      'calories': '1,709kcal',
      'breakfast':
          '밥1 / 반찬2 / 국1\n세트1: 밥, 김치, 달걀말이, 된장국\n세트2: 밥, 무생채, 불고기, 미역국',
      'lunch': '밥1 / 반찬2 / 국1\n세트1: 밥, 샐러드, 치킨스테이크, 콩나물국\n세트2: 밥, 나물, 생선구이, 무국',
      'dinner':
          '밥1 / 반찬2 / 국1\n세트1: 밥, 두부조림, 시금치무침, 닭곰탕\n세트2: 밥, 무생채, 불고기, 미역국',
    },
    2: {
      'calories': '1,500kcal',
      'carbs': '탄수화물 150g',
      'protein': '단백질 50g',
      'fat': '지방 40g',
      'breakfast':
          '밥1 / 반찬2 / 국1\n세트1: 밥, 생채, 참치캔, 김치찌개\n세트2: 밥, 멸치볶음, 계란후라이, 콩나물국',
      'lunch':
          '밥1 / 반찬2 / 국1\n세트1: 밥, 잡채, 동그랑땡, 시래기국\n세트2: 밥, 어묵볶음, 돼지불백, 된장찌개',
      'dinner':
          '밥1 / 반찬2 / 국1\n세트1: 밥, 가지볶음, 두부김치, 순두부찌개\n세트2: 밥, 계란찜, 오이소박이, 김치국',
    },
    // 더 많은 데이터 추가 가능
  }; // 식단 데이터

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('추천 식단',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Quicksand',
            )), // 앱바 타이틀
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CalendarPage()), // 캘린더 페이지로 이동
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfilePage()), // 프로필 페이지로 이동
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 맹구님의 맞춤 식단 및 새로 추천 버튼
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '맹구님의 맞춤 식단',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // 새로운 추천 로직
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 173, 216, 230),
                    ),
                    child: const Text(
                      '새로 추천',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 날짜 선택 칩
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Row(
                  children: List.generate(7, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ChoiceChip(
                        label: Text(
                          '${index + 1}일차',
                          style: const TextStyle(
                            fontFamily: 'Quicksand',
                          ),
                        ),
                        selected: _selectedDay == index + 1,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedDay = index + 1;
                            _scrollController.animateTo(
                              index * 100.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
              // 칼로리 및 영양소 정보
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _mealData[_selectedDay]?['calories'] ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          _mealData[_selectedDay]?['carbs'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                        Text(
                          _mealData[_selectedDay]?['protein'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                        Text(
                          _mealData[_selectedDay]?['fat'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // 아침, 점심, 저녁 식단 카드
              buildMealCard('아침', _mealData[_selectedDay]?['breakfast'] ?? ''),
              buildMealCard('점심', _mealData[_selectedDay]?['lunch'] ?? ''),
              buildMealCard('저녁', _mealData[_selectedDay]?['dinner'] ?? ''),
            ],
          ),
        ),
      ),
    );
  }

  // 식사 카드 위젯 생성
  Widget buildMealCard(String mealTime, String mealInfo) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mealTime,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            mealInfo,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Quicksand',
            ),
          ),
        ],
      ),
    );
  }
}
