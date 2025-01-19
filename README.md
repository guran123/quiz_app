# Quiz App (Flutter)

## Description

This is a Flutter-based quiz application that allows users to take quizzes, submit answers, and view their results. The app fetches quiz data dynamically from an API, presents it to the user, and calculates the score based on correct answers. The final score is displayed on a result screen after completing all questions. The app is designed to be user-friendly with a clean and responsive UI.

## Features

- **Dynamic Quiz Fetching**: Fetch quiz questions from an API.
- **User Interaction**: Users can select answers using radio buttons.
- **Result Display**: Users can view their score after completing the quiz.
- **Quiz Navigation**: Users can navigate through questions, and once all questions are answered, they can see their results.
- **Clean UI**: Designed with Material Design principles for smooth user experience.

## Project Structure

Here is an overview of the project structure:


### 1. **`main.dart`**
This is the entry point for the application. It runs the `QuizScreen` widget, which is the main screen for displaying quiz questions.

### 2. **`models/quiz.dart`**
This file contains the `Quiz` model which defines the structure of the quiz data. It includes a list of questions and their possible answer options. Each question is represented by a description and a list of options.

### 3. **`services/api_service.dart`**
This service file is responsible for fetching quiz data from an API (or local mock data). The `fetchQuizData()` function simulates the fetching of quiz data from a remote server.

### 4. **`screens/quiz_screen.dart`**
The quiz screen displays each question one by one, along with the answer options. It tracks the user's answers, updates the score, and navigates to the result screen once all questions are answered.

### 5. **`screens/result_screen.dart`**
This screen shows the result after the user completes the quiz. It displays the total score and the number of questions answered correctly. There is also an option to retry the quiz.

### 6. **`screens/start_screen.dart`**
This screen is shown when the user first opens the app. It provides a button to start the quiz.

## How to Run the Project

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/quiz_app.git
   cd quiz_app

