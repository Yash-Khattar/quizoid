import 'package:http/http.dart' as http;

List questionList = [];
List correctAnswerList = [];
List incorrectAnswerList = [];

getQues(String topicCode) async {
  var url = Uri.parse(
      'https://opentdb.com/api.php?amount=5&category=${topicCode}&difficulty=medium&type=multiple');
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    print(response.statusCode);
  }
}
