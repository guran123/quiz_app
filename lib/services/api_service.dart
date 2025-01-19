import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/quiz.dart';

Future<Quiz> fetchQuizData() async {
  final response = await http.get(Uri.parse('https://api.jsonserve.com/Uw5CrX'));

  if (response.statusCode == 200) {
    return Quiz.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load quiz data');
  }
}
