import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 뒤로가기 버튼
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // 앱바 타이틀
        title: const Text(
          '캘린더',
          style: TextStyle(fontFamily: 'Quicksand'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            // 캘린더 타이틀
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '캘린더',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
            ),
            // 캘린더 위젯
            CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
              onDateChanged: (date) {},
            ),
          ],
        ),
      ),
    );
  }
}
