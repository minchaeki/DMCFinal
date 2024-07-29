import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'calendar_page.dart';
import 'profile_page.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({super.key});

  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  String _selectedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()); // 선택된 날짜
  final Map<String, Map<String, dynamic>> _healthData = {
    '혈압': {
      'high': 0,
      'low': 0,
      'data': <BloodPressureData>[],
    },
    '혈당': {
      'value': 0,
      'data': <BloodSugarData>[],
    },
    '체중': {
      'value': 0.0,
      'data': <WeightData>[],
    },
  }; // 건강 데이터

  // 날짜 선택 함수
  Future<void> _selectDate(BuildContext context, Function onSave) async {
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
      onSave();
    }
  }

  // 혈압 입력 다이얼로그 표시
  void _showBloodPressureDialog(BuildContext context) {
    final TextEditingController bloodPressureHighController =
        TextEditingController();
    final TextEditingController bloodPressureLowController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '$_selectedDate 혈압 기록',
            style: const TextStyle(fontFamily: 'Quicksand'),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: bloodPressureHighController,
                decoration: const InputDecoration(
                  labelText: '혈압 (최고)',
                  hintText: 'mmHg',
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: bloodPressureLowController,
                decoration: const InputDecoration(
                  labelText: '혈압 (최저)',
                  hintText: 'mmHg',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child:
                  const Text('취소', style: TextStyle(fontFamily: 'Quicksand')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:
                  const Text('저장', style: TextStyle(fontFamily: 'Quicksand')),
              onPressed: () {
                setState(() {
                  _healthData['혈압']!['high'] =
                      int.parse(bloodPressureHighController.text);
                  _healthData['혈압']!['low'] =
                      int.parse(bloodPressureLowController.text);
                  _healthData['혈압']!['data'].add(BloodPressureData(
                    _selectedDate,
                    int.parse(bloodPressureHighController.text),
                    int.parse(bloodPressureLowController.text),
                  ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // 혈당 입력 다이얼로그 표시
  void _showBloodSugarDialog(BuildContext context) {
    final TextEditingController bloodSugarController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '$_selectedDate 혈당 기록',
            style: const TextStyle(fontFamily: 'Quicksand'),
          ),
          content: TextField(
            controller: bloodSugarController,
            decoration: const InputDecoration(
              labelText: '혈당',
              hintText: 'mg/dL',
            ),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              child:
                  const Text('취소', style: TextStyle(fontFamily: 'Quicksand')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:
                  const Text('저장', style: TextStyle(fontFamily: 'Quicksand')),
              onPressed: () {
                setState(() {
                  _healthData['혈당']!['value'] =
                      int.parse(bloodSugarController.text);
                  _healthData['혈당']!['data'].add(BloodSugarData(
                    _selectedDate,
                    int.parse(bloodSugarController.text).toDouble(),
                  ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // 체중 입력 다이얼로그 표시
  void _showWeightDialog(BuildContext context) {
    final TextEditingController weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '$_selectedDate 체중 기록',
            style: const TextStyle(fontFamily: 'Quicksand'),
          ),
          content: TextField(
            controller: weightController,
            decoration: const InputDecoration(
              labelText: '체중',
              hintText: 'kg',
            ),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              child:
                  const Text('취소', style: TextStyle(fontFamily: 'Quicksand')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:
                  const Text('저장', style: TextStyle(fontFamily: 'Quicksand')),
              onPressed: () {
                setState(() {
                  _healthData['체중']!['value'] =
                      double.parse(weightController.text);
                  _healthData['체중']!['data'].add(WeightData(
                    _selectedDate,
                    double.parse(weightController.text),
                  ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('yyyy년 MM월 dd일 (E)', 'ko_KR')
        .format(DateTime.now()); // 날짜 포맷팅
    final String formattedTime =
        DateFormat('HH:mm').format(DateTime.now()); // 시간 포맷팅

    return Scaffold(
      appBar: AppBar(
        title: const Text('내 건강',
            style: TextStyle(color: Colors.white, fontFamily: 'Quicksand')),
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
              // 날짜 및 시간 표시
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 혈압 카드
              buildInfoCard(
                title: '혈압',
                onEdit: () {
                  _selectDate(context, () => _showBloodPressureDialog(context));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildBloodPressureColumn(
                        '최고', _healthData['혈압']!['high'].toString(), 'mmHg'),
                    buildBloodPressureColumn(
                        '최저', _healthData['혈압']!['low'].toString(), 'mmHg'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // 체중 카드
              buildInfoCard(
                title: '체중',
                onEdit: () {
                  _selectDate(context, () => _showWeightDialog(context));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_healthData['체중']!['value']} kg',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                          LineSeries<WeightData, String>(
                            dataSource:
                                _healthData['체중']!['data'].cast<WeightData>(),
                            xValueMapper: (WeightData data, _) => data.date,
                            yValueMapper: (WeightData data, _) => data.weight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // 혈당 카드
              buildInfoCard(
                title: '혈당',
                onEdit: () {
                  _selectDate(context, () => _showBloodSugarDialog(context));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_healthData['혈당']!['value']} mg/dL',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Quicksand',
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                          LineSeries<BloodSugarData, String>(
                            dataSource: _healthData['혈당']!['data']
                                .cast<BloodSugarData>(),
                            xValueMapper: (BloodSugarData data, _) => data.date,
                            yValueMapper: (BloodSugarData data, _) =>
                                data.value,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 정보 카드 위젯 생성
  Widget buildInfoCard({
    required String title,
    required Widget child,
    required Function onEdit,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 카드 타이틀 및 수정 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => onEdit(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  // 혈압 컬럼 위젯 생성
  Widget buildBloodPressureColumn(String label, String value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(label,
              style:
                  const TextStyle(color: Colors.grey, fontFamily: 'Quicksand')),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            ),
          ),
          Text(unit,
              style:
                  const TextStyle(color: Colors.grey, fontFamily: 'Quicksand')),
        ],
      ),
    );
  }
}

// 체중 데이터 클래스
class WeightData {
  WeightData(this.date, this.weight);
  final String date;
  final double weight;
}

// 혈당 데이터 클래스
class BloodSugarData {
  BloodSugarData(this.date, this.value);
  final String date;
  final double value;
}

// 혈압 데이터 클래스
class BloodPressureData {
  BloodPressureData(this.date, this.high, this.low);
  final String date;
  final int high;
  final int low;
}
