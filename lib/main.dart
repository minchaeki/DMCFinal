import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() async {
  // Initialize the date formatting
  await initializeDateFormatting('ko_KR', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/dmc_logo.png', height: 100), // DMC 로고 이미지
              SizedBox(height: 16),
              Text(
                'DMC',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: Colors.white),
                obscureText: true,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  'SIGN IN',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupPage1()),
                  );
                },
                child: Text(
                  '회원가입',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    HealthPage(),
    ReportPage(),
    NewsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        selectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '내 건강',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: '리포트',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '뉴스',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('yyyy년 MM월 dd일 (E)', 'ko_KR').format(DateTime.now());
    final String formattedTime = DateFormat('HH:mm').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('DMC', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formattedTime,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              buildInfoCard(
                title: '식단',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '0 kcal',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        buildNutrientIndicator('탄', Colors.purple, 0),
                        buildNutrientIndicator('단', Colors.blue, 0),
                        buildNutrientIndicator('지', Colors.green, 0),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodLogPage()),
                        );
                      },
                      child: Text('오늘 뭐 드셨나요?'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              buildInfoCard(
                title: '체중',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '64 kg',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 150,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                          LineSeries<WeightData, String>(
                            dataSource: [
                              WeightData('1월', 64),
                              WeightData('2월', 63),
                              WeightData('3월', 65),
                              WeightData('4월', 66),
                              WeightData('5월', 64),
                            ],
                            xValueMapper: (WeightData data, _) => data.month,
                            yValueMapper: (WeightData data, _) => data.weight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              buildInfoCard(
                title: '혈당',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BloodSugarPage()),
                        );
                      },
                      child: Container(
                        height: 150,
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            LineSeries<BloodSugarData, String>(
                              dataSource: [
                                BloodSugarData('1월', 85),
                                BloodSugarData('2월', 90),
                                BloodSugarData('3월', 100),
                                BloodSugarData('4월', 75),
                                BloodSugarData('5월', 80),
                              ],
                              xValueMapper: (BloodSugarData data, _) =>
                                  data.month,
                              yValueMapper: (BloodSugarData data, _) =>
                                  data.value,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '고혈당 문제 발생',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              buildInfoCard(
                title: '오늘 걸음 수',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '5,964',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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

  Widget buildInfoCard({required String title, required Widget child}) {
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
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  Widget buildNutrientIndicator(String label, Color color, int percentage) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          color: color,
        ),
        SizedBox(width: 4),
        Text('$label $percentage%'),
        SizedBox(width: 8),
      ],
    );
  }
}

class HealthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('yyyy년 MM월 dd일 (E)', 'ko_KR').format(DateTime.now());
    final String formattedTime = DateFormat('HH:mm').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('내 건강', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formattedTime,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              buildInfoCard(
                title: '고혈압',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildBloodPressureColumn('최고', '158', 'mmHg'),
                        buildBloodPressureColumn('최저', '132', 'mmHg'),
                        buildBloodPressureColumn('맥박', '82', 'bpm'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildBloodPressureColumn('평균', '142', ''),
                        buildBloodPressureColumn('맥압', '13', ''),
                        buildBloodPressureColumn('심부담도', '12555', ''),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              buildInfoCard(
                title: '체중',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                          LineSeries<WeightData, String>(
                            dataSource: [
                              WeightData('1월', 64),
                              WeightData('2월', 63),
                              WeightData('3월', 65),
                              WeightData('4월', 66),
                              WeightData('5월', 64),
                            ],
                            xValueMapper: (WeightData data, _) => data.month,
                            yValueMapper: (WeightData data, _) => data.weight,
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

  Widget buildInfoCard({required String title, required Widget child}) {
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
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }

  Widget buildBloodPressureColumn(String label, String value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(unit, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class BloodSugarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('혈당', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '혈당',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '83점',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('업데이트: 오전 9:37'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('센서 3일차'),
                        Text('통계'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 200,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries>[
                          LineSeries<BloodSugarData, String>(
                            dataSource: [
                              BloodSugarData('1월', 85),
                              BloodSugarData('2월', 90),
                              BloodSugarData('3월', 100),
                              BloodSugarData('4월', 75),
                              BloodSugarData('5월', 80),
                            ],
                            xValueMapper: (BloodSugarData data, _) =>
                                data.month,
                            yValueMapper: (BloodSugarData data, _) =>
                                data.value,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Text('59 mg/dL', style: TextStyle(fontSize: 24)),
            Text('오전 8시 6분', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('뉴스', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 14, // 예제: 뉴스 기사 14개
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text('뉴스 제목 $index'),
                  subtitle: Text('뉴스 요약 $index'),
                  onTap: () {},
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String nickname = "맹구박사";
  String birthdate = "2006년 10월 22일";
  String gender = "남성";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('마이페이지'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        AssetImage('assets/profile_image.png'), // 프로필 이미지 경로
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            buildProfileField("이름 또는 닉네임", nickname, (newValue) {
              setState(() {
                nickname = newValue;
              });
            }),
            buildProfileField("생년월일", birthdate, (newValue) {
              setState(() {
                birthdate = newValue;
              });
            }),
            buildProfileField("성별", gender, (newValue) {
              setState(() {
                gender = newValue;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField(
      String label, String value, Function(String) onEdit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _showEditDialog(context, label, value, onEdit);
              },
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  void _showEditDialog(BuildContext context, String label, String value,
      Function(String) onEdit) {
    TextEditingController controller = TextEditingController(text: value);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$label 수정'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: label,
            ),
          ),
          actions: [
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('저장'),
              onPressed: () {
                onEdit(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class SignupPage1 extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('회원가입'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupPage2()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildTextField("아이디", "아이디 입력", _idController, true),
            buildTextField("이메일", "이메일 입력(선택)", _emailController, false),
            buildTextField("비밀번호", "비밀번호 입력", _passwordController, true,
                obscureText: true),
            buildTextField("비밀번호", "비밀번호 재입력", _passwordConfirmController, true,
                obscureText: true),
            buildTextField("휴대폰 번호", "010 0000 0000", _phoneController, false),
            buildTextField("생년월일", "생년월일 입력", _birthdateController, false),
            buildTextField("성별", "성별 입력", _genderController, false),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String placeholder,
      TextEditingController controller, bool isRequired,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          obscureText: obscureText,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class SignupPage2 extends StatefulWidget {
  @override
  _SignupPage2State createState() => _SignupPage2State();
}

class _SignupPage2State extends State<SignupPage2> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  List<String> _conditions = ["당뇨", "고혈압", "해당 사항 없음"];
  List<bool> _selectedConditions = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildTextField("키", "cm", _heightController),
            buildTextField("몸무게", "kg", _weightController),
            Text("갖고 있는 질환", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Wrap(
              spacing: 10.0,
              children: _conditions.asMap().entries.map((entry) {
                int idx = entry.key;
                String condition = entry.value;
                return ChoiceChip(
                  label: Text(condition),
                  selected: _selectedConditions[idx],
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedConditions[idx] = selected;
                    });
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.grey[200],
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 회원가입 완료 처리 로직
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                },
                child: Text('기록하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, String unit, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: unit,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('캘린더'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '캘린더',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
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

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('알림 센터'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('알림'),
            subtitle: Text('금일 식사 정보를 입력해주세요.'),
          ),
        ],
      ),
    );
  }
}

class WeightData {
  WeightData(this.month, this.weight);
  final String month;
  final double weight;
}

class BloodSugarData {
  BloodSugarData(this.month, this.value);
  final String month;
  final double value;
}

class FoodLogPage extends StatefulWidget {
  @override
  _FoodLogPageState createState() => _FoodLogPageState();
}

class _FoodLogPageState extends State<FoodLogPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedMeal = '아침';

  List<String> _foodItems = [
    '흰쌀밥 1공기(200g) 250kcal',
    '된장국 1인분(200g) 76kcal',
    '닭다리살 깐닭 200g 350kcal',
    '배추김치 1반찬그릇(40g) 14kcal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('음식 기록'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '음식명, 브랜드명으로 검색',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '자주 드셨어요',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('취소'),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildMealButton('아침'),
                buildMealButton('점심'),
                buildMealButton('저녁'),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _foodItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_foodItems[index]),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 기록하기 로직
                },
                child: Text('기록하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMealButton(String meal) {
    return ChoiceChip(
      label: Text(meal),
      selected: _selectedMeal == meal,
      onSelected: (selected) {
        setState(() {
          _selectedMeal = meal;
        });
      },
    );
  }
}

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int _selectedPeriod = 0; // 0: 일간, 1: 주간, 2: 월간
  bool _hasData = false;

  List<ChartData> _chartData = [
    ChartData('탄수화물', 65.1, Colors.blue),
    ChartData('단백질', 29.1, Colors.green),
    ChartData('지방', 5.8, Colors.red)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리포트', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPeriodButton('일간', 0),
                _buildPeriodButton('주간', 1),
                _buildPeriodButton('월간', 2),
              ],
            ),
            SizedBox(height: 16),
            _buildDateSelector(),
            SizedBox(height: 16),
            _hasData ? _buildReportContent() : _buildEmptyReport(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPeriod = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: _selectedPeriod == index ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _selectedPeriod == index ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 날짜 변경 로직
          },
        ),
        Text(
          '오늘',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            // 날짜 변경 로직
          },
        ),
      ],
    );
  }

  Widget _buildEmptyReport() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.insert_drive_file, size: 100, color: Colors.grey),
        SizedBox(height: 16),
        Text(
          '아직 기록된 식단이 없어요',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
        SizedBox(height: 8),
        Text(
          '기록 페이지에서 식단을 기록하면\n리포트를 확인할 수 있어요',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildReportContent() {
    return Column(
      children: [
        Text(
          '하루 영양소를 미달했어요',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNutrientStatus('칼로리', '미달'),
            _buildNutrientStatus('탄수화물', '미달'),
            _buildNutrientStatus('단백질', '미달'),
            _buildNutrientStatus('지방', '미달'),
            _buildNutrientStatus('나트륨', '미달'),
            _buildNutrientStatus('당분', '미달'),
          ],
        ),
        SizedBox(height: 16),
        Text(
          '하루 689Kcal를 먹었어요\n지나친 절식은 위험해요',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Container(
          height: 200,
          child: SfCircularChart(
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                dataSource: _chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNutrientStatus(String nutrient, String status) {
    return Column(
      children: [
        Text(
          nutrient,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Text(
          status,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
