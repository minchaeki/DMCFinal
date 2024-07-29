import 'package:flutter/material.dart';
import 'signup_page2.dart';

class SignupPage1 extends StatelessWidget {
  // 입력 필드 컨트롤러
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _locationController =
      TextEditingController(); // 지역 필드 컨트롤러

  SignupPage1({super.key}); // 생성자

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
        title: const Text('회원가입'), // 앱바 타이틀
        actions: [
          // 다음 페이지로 이동 버튼
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupPage2()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 아이디 입력 필드
            buildTextField("아이디", "아이디 입력", _idController, true),
            // 이메일 입력 필드 (선택)
            buildTextField("이메일", "이메일 입력(선택)", _emailController, false),
            // 비밀번호 입력 필드
            buildTextField("비밀번호", "비밀번호 입력", _passwordController, true,
                obscureText: true),
            // 비밀번호 재입력 필드
            buildTextField("비밀번호", "비밀번호 재입력", _passwordConfirmController, true,
                obscureText: true),
            // 휴대폰 번호 입력 필드
            buildTextField("휴대폰 번호", "010 0000 0000", _phoneController, false),
            // 생년월일 입력 필드
            buildTextField("생년월일", "생년월일 입력", _birthdateController, false),
            // 성별 입력 필드
            buildTextField("성별", "성별 입력", _genderController, false),
            // 사는 지역 입력 필드
            buildTextField("사는 지역", "지역 입력", _locationController, false),
          ],
        ),
      ),
    );
  }

  // 텍스트 필드 빌드 함수
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Quicksand',
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: const TextStyle(fontFamily: 'Quicksand'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          obscureText: obscureText,
          style: const TextStyle(fontFamily: 'Quicksand'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
