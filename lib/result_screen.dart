import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quizoid/const.dart';
import 'package:quizoid/topic_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key, required this.score}) : super(key: key);
  final int score;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kprimarycolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kprimarycolor,
        centerTitle: true,
        title: Text('Result', style: kAppBarTextStyle),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Total correct answers',
              style: knextButtonTextstyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              '${widget.score} out of 5 Questions',
              style: kresultTextStyle,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.9,
                // Below is the code for Linear Gradient.
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  gradient: LinearGradient(
                    colors: [kgradientstartcolor, kgradientendcolor],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const AutoSizeText(
                        'Your final score is',
                        maxLines: 1,
                        style: kfinalResultTextStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${widget.score * 10}',
                      style: kscoreTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(60),
                primary: kbuttoncolor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
              ),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TopicScreen())),
              child: const Text(
                'Play Again',
                style: knextbuttonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//  Container(
//                   margin: EdgeInsets.all(60),
//                   decoration: const BoxDecoration(
//                     color: kyellowcolor,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Text(
//                     'hhh',
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
 // child: Container(
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/Card_Gradient.png'),
              //       fit: BoxFit.contain,
              //     ),
              //     borderRadius: BorderRadius.all(Radius.circular(35)),
              //   ),
              //   child: Text(
              //     'hhh',
              //     textAlign: TextAlign.center,
              //   ),
              // ),