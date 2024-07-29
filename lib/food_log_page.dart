import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'calendar_page.dart';
import 'profile_page.dart';

class FoodLogPage extends StatefulWidget {
  const FoodLogPage({super.key});

  @override
  FoodLogPageState createState() => FoodLogPageState();
}

class FoodLogPageState extends State<FoodLogPage> {
  final TextEditingController _foodController =
      TextEditingController(); // 음식 입력 컨트롤러
  final TextEditingController _commentController =
      TextEditingController(); // 코멘트 입력 컨트롤러
  final TextEditingController _gramsController =
      TextEditingController(); // 그램 입력 컨트롤러
  String _selectedMeal = '아침'; // 선택된 식사
  String _selectedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()); // 선택된 날짜
  final ImagePicker _picker = ImagePicker(); // 이미지 선택기
  final List<String> _foodItems = []; // 음식 아이템 리스트
  Map<String, List<Map<String, dynamic>>> _mealLogs = {
    '아침': [],
    '점심': [],
    '저녁': [],
  }; // 식사 로그

  // _mealLogs의 Getter
  Map<String, List<Map<String, dynamic>>> get mealLogs => _mealLogs;

  @override
  void initState() {
    super.initState();
    _clearLogsAtMidnight(); // 자정에 로그 초기화
  }

  void _clearLogsAtMidnight() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final duration = nextMidnight.difference(now);

    Future.delayed(duration, () {
      setState(() {
        _mealLogs = {
          '아침': [],
          '점심': [],
          '저녁': [],
        };
      });
      _clearLogsAtMidnight(); // 자정에 다시 로그 초기화
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera); // 카메라에서 이미지 선택
    if (pickedFile != null) {
      setState(() {
        _foodItems.add(pickedFile.path); // 선택된 이미지 경로 추가
      });
    }
  }

  void _addFoodItem(String food, String comment, String grams) {
    setState(() {
      _mealLogs[_selectedMeal]?.add({
        'food': food,
        'comment': comment,
        'grams': grams,
        'date': _selectedDate,
        'imagePath': _foodItems.isNotEmpty ? _foodItems.last : null,
        'time': DateFormat('HH:mm:ss').format(DateTime.now()),
      });
      _foodController.clear(); // 음식 입력 필드 초기화
      _commentController.clear(); // 코멘트 입력 필드 초기화
      _gramsController.clear(); // 그램 입력 필드 초기화
      _foodItems.clear(); // 음식 아이템 리스트 초기화
    });
  }

  void _removeFoodItem(String meal, int index) {
    setState(() {
      _mealLogs[meal]?.removeAt(index); // 식사 로그에서 음식 아이템 제거
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ); // 날짜 선택기 표시
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(picked); // 선택된 날짜 설정
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('음식 기록',
            style: TextStyle(color: Colors.white, fontFamily: 'Quicksand')),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CalendarPage()),
              ); // 캘린더 페이지로 이동
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              ); // 프로필 페이지로 이동
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildMealButton('아침'), // 아침 버튼 생성
                buildMealButton('점심'), // 점심 버튼 생성
                buildMealButton('저녁'), // 저녁 버튼 생성
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _foodController,
                    decoration: InputDecoration(
                      hintText: '음식 입력',
                      hintStyle: const TextStyle(fontFamily: 'Quicksand'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: _pickImage, // 이미지 선택 버튼
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _gramsController,
              decoration: InputDecoration(
                hintText: '그램 입력',
                hintStyle: const TextStyle(fontFamily: 'Quicksand'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.number, // 숫자 입력 키보드 타입
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: '코멘트 입력',
                hintStyle: const TextStyle(fontFamily: 'Quicksand'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              maxLines: null, // 멀티라인 입력 허용
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_foodController.text.isNotEmpty &&
                    _commentController.text.isNotEmpty &&
                    _gramsController.text.isNotEmpty) {
                  _addFoodItem(_foodController.text, _commentController.text,
                      _gramsController.text); // 음식 아이템 추가
                }
              },
              child:
                  const Text('기록하기', style: TextStyle(fontFamily: 'Quicksand')),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _selectDate(context); // 날짜 선택
              },
              child: Text('날짜 선택: $_selectedDate',
                  style: const TextStyle(fontFamily: 'Quicksand')),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _mealLogs[_selectedMeal]?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = _mealLogs[_selectedMeal]![index];
                  return Dismissible(
                    key: Key(item['time']),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _removeFoodItem(_selectedMeal, index); // 음식 아이템 제거
                    },
                    background: Container(color: Colors.red),
                    child: ListTile(
                      title: Text('${item['food']}',
                          style: const TextStyle(fontFamily: 'Quicksand')),
                      subtitle: Text(
                          '코멘트: ${item['comment']} (그램: ${item['grams']})',
                          style: const TextStyle(
                              fontFamily: 'Quicksand')), // 음식 아이템 정보 표시
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMealButton(String meal) {
    return ChoiceChip(
      label: Text(meal, style: const TextStyle(fontFamily: 'Quicksand')),
      selected: _selectedMeal == meal,
      onSelected: (selected) {
        setState(() {
          _selectedMeal = meal; // 선택된 식사 설정
        });
      },
    );
  }
}
