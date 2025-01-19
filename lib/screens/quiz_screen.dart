import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:quiz_app/services/api_service.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<Quiz> futureQuiz;
  int score = 0;
  int currentQuestionIndex = 0;
  String? selectedAnswer;

  @override
  void initState() {
    super.initState();
    futureQuiz = fetchQuizData();
  }

  void onAnswerSelected(String answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  void onSubmitAnswer(Quiz quiz) {
    if (selectedAnswer != null) {
      final currentQuestion = quiz.questions[currentQuestionIndex];
      final selectedOption = currentQuestion.options.firstWhere((option) => option.description == selectedAnswer);


      if (selectedOption.isCorrect) {
        setState(() {
          score += 1;
        });
      }


      if (currentQuestionIndex < quiz.questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedAnswer = null;
        });
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              score: score,
              totalQuestions: quiz.questions.length,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<Quiz>(
        future: futureQuiz,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final quiz = snapshot.data!;
            final question = quiz.questions[currentQuestionIndex];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: (currentQuestionIndex + 1) / quiz.questions.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Question ${currentQuestionIndex + 1}/${quiz.questions.length}',
                    style: TextStyle(fontSize: 18, color: Colors.deepPurple),
                  ),
                  SizedBox(height: 10),
                  Text(
                    question.description,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  Expanded(
                    child: ListView(
                      children: question.options.map((option) {
                        return RadioListTile<String>(
                          title: Text(
                            option.description,
                            style: TextStyle(fontSize: 18),
                          ),
                          value: option.description,
                          groupValue: selectedAnswer,
                          onChanged: (value) {
                            onAnswerSelected(value!);
                          },
                        );
                      }).toList(),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () => onSubmitAnswer(quiz),
                        child: Text(
                          currentQuestionIndex == quiz.questions.length - 1
                              ? 'Finish Quiz'
                              : 'Next Question',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(child: Text('No Data Available'));
        },
      ),
    );
  }
}
