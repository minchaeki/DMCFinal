import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'login_page.dart';

// 메인 함수, 애플리케이션 진입점
void main() async {
  // 한국 로케일 날짜 형식 초기화
  await initializeDateFormatting('ko_KR', null);
  // MyApp 위젯 실행
  runApp(const MyApp());
}

// 애플리케이션의 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 시작 페이지를 LoginPage로 설정
      home: LoginPage(),
    );
  }
}
