import 'package:flutter/material.dart';
import 'dart:math'; // 랜덤 숫자를 위해 추가
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text('주사위 굴리기'),
          backgroundColor: Colors.blueGrey[800],
        ),
        body: const DicePage(), // body를 DicePage 위젯으로 변경
      ),
    );
  }
}

// 상태가 있는 위젯으로 변경
class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  // 주사위 번호를 저장할 변수 (초기값 1)
  int diceNumber = 1;
  
  // AudioPlayer 인스턴스 생성
  final AudioPlayer audioPlayer = AudioPlayer();

  void rollDice() async {
    // 소리 재생
    try {
      await audioPlayer.play(AssetSource('sound/Shake_And_Roll_Dice.mp3'));
    } catch (e) {
      print('소리 재생 오류: $e');
    }
    
    // setState 안에서 변수를 바꾸어야 화면이 새로고침됩니다.
    setState(() {
      // 1부터 6까지의 랜덤 숫자 생성
      diceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column( // 위젯을 세로로 배치하기 위해 Column 사용
        mainAxisAlignment: MainAxisAlignment.center, // 세로축 중앙 정렬
        children: [
          // 주사위 이미지
          Image.asset('assets/images/$diceNumber.png', width: 200),
          
          const SizedBox(height: 40), // 이미지와 버튼 사이의 간격

          // 굴리기 버튼
          TextButton(
            onPressed: rollDice, // 버튼을 누르면 rollDice 함수 실행
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueGrey[700],
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: const Text(
              '굴리기',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}