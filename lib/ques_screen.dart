import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quizoid/const.dart';
import 'package:quizoid/question.dart';
import 'result_screen.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class QuesScreen extends StatefulWidget {
  const QuesScreen(this.data, {Key? key}) : super(key: key);
  final String data;

  @override
  State<QuesScreen> createState() => _QuesScreenState();
}

class _QuesScreenState extends State<QuesScreen> {
  List<Question> quesbank = [];
  List optionList = [];

  String question = '';
  String correctAnswer = '';
  List incorrectAnswer = [];

  int quesNumber = 0;
  int randomIndex = 0;
  int scoreKeeper = 0;

  bool colorToggleA = false;
  bool colorToggleB = false;
  bool colorToggleC = false;
  bool colorToggleD = false;
  bool pressAttentionA = false;
  bool pressAttentionB = false;
  bool pressAttentionC = false;
  bool pressAttentionD = false;

  final correctPlayer = AssetsAudioPlayer();
  final incorrectPlayer = AssetsAudioPlayer();

  void playCorrect() {
    correctPlayer.play();
  }

  void playIncorrect() {
    incorrectPlayer.play();
  }

  @override
  void initState() {
    super.initState();
    getQuesData();

    correctPlayer.open(Audio("assets/correct.wav"), autoStart: false);
    incorrectPlayer.open(Audio("assets/incorrect.wav"), autoStart: false);
    // print(widget.data);
  }

  void getQuesData() {
    for (int i = 0; i < 5; i++) {
      question = jsonDecode(widget.data)['results'][i]['question'];
      question = question
          .replaceAll('&quot;', '"')
          .replaceAll('&#039;', "'")
          .replaceAll('&ldquo;', '"')
          .replaceAll('&rdquo;', '"')
          .replaceAll('&rsquo;', "'")
          .replaceAll('&lsquo;', "'");

      correctAnswer = jsonDecode(widget.data)['results'][i]['correct_answer'];
      print(correctAnswer);

      incorrectAnswer =
          jsonDecode(widget.data)['results'][i]['incorrect_answers'];

      randomIndex = Random().nextInt(4);

      incorrectAnswer.insert(randomIndex, correctAnswer);
      for (int i = 0; i < 4; i++) {
        optionList.add(incorrectAnswer[i]
            .replaceAll('&quot;', '"')
            .replaceAll('&#039;', "'")
            .replaceAll('&ldquo;', '"')
            .replaceAll('&rsquo;', "'")
            .replaceAll('&lsquo;', "'"));
      }
      optionList.shuffle();
      // print(optionList);

      Question q = Question(
          question: question.isNotEmpty ? question : 'error',
          optionA: optionList.isNotEmpty ? optionList[0] : 'error',
          optionB: optionList.isNotEmpty ? optionList[1] : 'error',
          optionC: optionList.isNotEmpty ? optionList[2] : 'error',
          optionD: optionList.isNotEmpty ? optionList[3] : 'error',
          correctAns: correctAnswer);
      quesbank.add(q);
      optionList.clear();
    }
  }

  checkAnswer(String userAnswer) {
    if (quesbank[quesNumber].correctAns == userAnswer) {
      scoreKeeper++;
      playCorrect();
      // print(scoreKeeper);

      return true;
    } else {
      if (quesbank[quesNumber].correctAns == quesbank[quesNumber].optionA) {
        pressAttentionA = true;
        colorToggleA = true;
      }
      if (quesbank[quesNumber].correctAns == quesbank[quesNumber].optionB) {
        pressAttentionB = true;
        colorToggleB = true;
      }
      if (quesbank[quesNumber].correctAns == quesbank[quesNumber].optionC) {
        pressAttentionC = true;
        colorToggleC = true;
      }
      if (quesbank[quesNumber].correctAns == quesbank[quesNumber].optionD) {
        pressAttentionD = true;
        colorToggleD = true;
      }
      // print('wrong ans');
      playIncorrect();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimarycolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          'Quizoid',
          style: kAppBarTextStyle,
        )),
        elevation: 0.0,
        backgroundColor: kprimarycolor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Ques no. ${quesNumber + 1}',
                    style: kquesNoIndicatorTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                  child: Center(
                    child: AutoSizeText(
                      quesbank[quesNumber].question,
                      style: kquesTextStyle,
                      maxLines: 6,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: pressAttentionA
                          ? colorToggleA
                              ? kgreencolor
                              : kredcolor
                          : kbuttoncolor,
                    ),
                    onPressed: () {
                      setState(() {
                        pressAttentionA = !pressAttentionA;
                        colorToggleA =
                            checkAnswer(quesbank[quesNumber].optionA);
                      });
                    },
                    child: AutoSizeText(
                      quesbank[quesNumber].optionA,
                      style: koptionTextstyle,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: pressAttentionB
                          ? colorToggleB
                              ? kgreencolor
                              : kredcolor
                          : kbuttoncolor,
                    ),
                    onPressed: () {
                      setState(() {
                        pressAttentionB = !pressAttentionB;
                        colorToggleB =
                            checkAnswer(quesbank[quesNumber].optionB);
                      });
                    },
                    child: AutoSizeText(
                      quesbank[quesNumber].optionB,
                      style: koptionTextstyle,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: pressAttentionC
                          ? colorToggleC
                              ? kgreencolor
                              : kredcolor
                          : kbuttoncolor,
                    ),
                    onPressed: () {
                      setState(() {
                        pressAttentionC = !pressAttentionC;
                        colorToggleC =
                            checkAnswer(quesbank[quesNumber].optionC);
                      });
                    },
                    child: AutoSizeText(
                      quesbank[quesNumber].optionC,
                      style: koptionTextstyle,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      primary: pressAttentionD
                          ? colorToggleD
                              ? kgreencolor
                              : kredcolor
                          : kbuttoncolor,
                    ),
                    onPressed: () {
                      setState(() {
                        pressAttentionD = !pressAttentionD;
                        colorToggleD =
                            checkAnswer(quesbank[quesNumber].optionD);
                      });
                    },
                    child: AutoSizeText(
                      quesbank[quesNumber].optionD,
                      style: koptionTextstyle,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: pressAttentionA == true ||
                      pressAttentionB == true ||
                      pressAttentionC == true ||
                      pressAttentionD == true
                  ? () {
                      setState(() {
                        quesNumber != 4
                            ? quesNumber++
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ResultScreen(score: scoreKeeper)));
                        pressAttentionA = false;
                        pressAttentionB = false;
                        pressAttentionC = false;
                        pressAttentionD = false;
                        colorToggleA = false;
                        colorToggleB = false;
                        colorToggleC = false;
                        colorToggleD = false;
                        optionList.clear();
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                primary: kbuttoncolor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: const Text(
                  'Next',
                  style: knextButtonTextstyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ReusableOption extends StatelessWidget {
//   ReusableOption({
//     required this.quesbank,
//     required this.quesNumber,
//     required this.OptionNo,
//   });

//   final List<Question> quesbank;
//   final int quesNumber;
//   final Object OptionNo;

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () {},
//       child: Text(quesbank[quesNumber].OptionNo),
//     );
//   }
// }
