import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:quizoid/const.dart';
import 'package:quizoid/ques_screen.dart';
import 'package:quizoid/http.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  Map topicName = {
    'General Knowledge': "9",
    'Books': "10",
    'Film': "11",
    'Music': "12",
    'TV': "14",
    'Video Games': "15",
    'Sports': "21",
    'Geography': "22",
    'Art': "25",
    'Comic': "29",
    'Manga': "31",
    'Cartoon Animation': "32",
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
          slideIconWidget: const Icon(Icons.arrow_back_ios),
          positionSlideIcon: 0.87,
          waveType: WaveType.liquidReveal,

          //pages info
          pages: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/quizoid_splashScreen.png'),
                fit: BoxFit.cover,
              )),
            ),
            Pages(
              color: Colors.green,
              pageTitle: 'Animation',
              buttonImage1: 'assets/Manga.png',
              topicCode1: topicName['Manga'],
              buttonImage2: 'assets/Video Games.png',
              topicCode2: topicName['Video Games'],
              buttonImage3: 'assets/Cartoon Animation.png',
              topicCode3: topicName['Cartoon Animation'],
              buttonImage4: 'assets/Comic.png',
              topicCode4: topicName['Comic'],
            ),
            Pages(
              color: Colors.pink,
              pageTitle: 'Entertaintment',
              buttonImage1: 'assets/Music.png',
              topicCode1: topicName['Music'],
              buttonImage2: 'assets/Books.png',
              topicCode2: topicName['Books'],
              buttonImage3: 'assets/Film.png',
              topicCode3: topicName['Film'],
              buttonImage4: 'assets/TV.png',
              topicCode4: topicName['TV'],
            ),
            Pages(
              color: Colors.indigo,
              pageTitle: 'General',
              buttonImage1: 'assets/Art.png',
              topicCode1: topicName['Art'],
              buttonImage2: 'assets/Sports.png',
              topicCode2: topicName['Sports'],
              buttonImage3: 'assets/General Knowledge.png',
              topicCode3: topicName['General Knowledge'],
              buttonImage4: 'assets/Geography.png',
              topicCode4: topicName['Geography'],
            ),
          ]),
    );
  }
}

// pages body container reused
class Pages extends StatelessWidget {
  const Pages({
    required this.color,
    required this.pageTitle,
    required this.buttonImage1,
    required this.buttonImage2,
    required this.buttonImage3,
    required this.buttonImage4,
    required this.topicCode1,
    required this.topicCode2,
    required this.topicCode3,
    required this.topicCode4,
  });
  final Color color;
  final String pageTitle;
  final String buttonImage1;
  final String buttonImage2;
  final String buttonImage3;
  final String buttonImage4;
  final String topicCode1;
  final String topicCode2;
  final String topicCode3;
  final String topicCode4;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          kHeadText,
          Text(pageTitle, style: ktopicHeadingText),
          Column(
            children: [
              Row(
                children: [
                  TopicButton(buttonImage: buttonImage1, topicCode: topicCode1),
                  TopicButton(buttonImage: buttonImage2, topicCode: topicCode2),
                ],
              ),
              Row(
                children: [
                  TopicButton(buttonImage: buttonImage3, topicCode: topicCode3),
                  TopicButton(buttonImage: buttonImage4, topicCode: topicCode4),
                ],
              ),
            ],
          ),
          const Text(
            'Swipe for more Topics',
            style: kBottomTextStyle,
          ),
        ],
      ),
    );
  }
}

// buttons reused
class TopicButton extends StatelessWidget {
  const TopicButton({
    Key? key,
    required this.buttonImage,
    required this.topicCode,
  }) : super(key: key);

  final String buttonImage;
  final String topicCode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
          ),
          child: Image.asset(
            buttonImage,
          ),
          onPressed: () async {
            var data = await getQues(topicCode);

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => QuesScreen(data)));
          },
        ),
      ),
    );
  }
}
