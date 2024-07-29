import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'food_log_page.dart'; // 식단 기록 페이지 임포트
import 'profile_page.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String _selectedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()); // 선택된 날짜
  Map<String, List<Map<String, dynamic>>> _mealLogs = {
    '아침': [],
    '점심': [],
    '저녁': [],
  }; // 식사 로그 데이터

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final foodLogPageState =
        context.findAncestorStateOfType<FoodLogPageState>();
    if (foodLogPageState != null) {
      setState(() {
        _mealLogs = foodLogPageState.mealLogs;
      });
    }
  }

  // 날짜 선택 함수
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // 앱 평점 계산 함수 (예시 로직)
  int _calculateAppRating(List<Map<String, dynamic>> logs) {
    return logs.isNotEmpty ? 5 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('리포트',
            style: TextStyle(
                color: Colors.white, fontFamily: 'Quicksand')), // 앱바 타이틀
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              _selectDate(context); // 날짜 선택 함수 호출
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 날짜 선택 버튼
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _selectDate(context); // 날짜 선택 함수 호출
                },
                child: Text('날짜 선택: $_selectedDate',
                    style: const TextStyle(fontFamily: 'Quicksand')),
              ),
            ),
            const SizedBox(height: 16),
            // 평점 표시
            Text(
              '평점 (5점 만점): ${_calculateAppRating(_mealLogs.values.expand((list) => list).toList())}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
            const SizedBox(height: 16),
            // 리포트 내용 표시
            Expanded(
              child: _buildReportContent(),
            ),
          ],
        ),
      ),
    );
  }

  // 리포트 내용 빌드 함수
  Widget _buildReportContent() {
    List<Map<String, dynamic>> selectedLogs = _mealLogs.values
        .expand((list) => list)
        .where((log) => log['date'] == _selectedDate)
        .toList()
      ..sort((a, b) => a['time'].compareTo(b['time']));

    if (selectedLogs.isEmpty) {
      return const Center(
        child: Text('기록된 식단이 없습니다.', style: TextStyle(fontFamily: 'Quicksand')),
      );
    }

    return ListView.builder(
      itemCount: selectedLogs.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> log = selectedLogs[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log['time'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
                if (log['imagePath'] != null) ...[
                  const SizedBox(height: 8),
                  Image.file(File(log['imagePath'])), // 이미지 표시
                ],
                const SizedBox(height: 8),
                Text(
                  '식단: ${log['food']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '그램: ${log['grams']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '평가 (5점 만점): ${_calculateAppRating([log])}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Quicksand',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '코멘트: ${log['comment']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Quicksand',
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
