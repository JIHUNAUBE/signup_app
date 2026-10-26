# Flutter Signup Form Quest

## Project Information

**Course:** CSC 4360 – Mobile Application Development  
**Activity:** In-Class Activity 10  
**Track:** Undergraduate  
**Task:** Task A – AI Signup Coach (Mock Practice)  
**Student:** Jihun Kim  
<<<<<<< HEAD

=======
>>>>>>> 988193d (Add undergraduate reflection answers)

## Project Description

This project is a simple signup form built with Flutter and Dart. Users can enter their name, email, and password. The app checks the input and displays error messages when something is missing or invalid.

The app also includes a mock signup tip feature. It shows a loading indicator, a signup tip, and an error message with a retry button.

## Features

- Name, email, and password validation
- Password must have at least 6 characters
- Green SnackBar for successful validation
- Mock signup advice
- Loading indicator and retry button
- Simple Flutter UI

## Mock Service

I used a local mock service because no AI endpoint URL was provided. The app waits two seconds before showing a predefined signup tip. No live AI model is called, and no personal information is sent to a server.

## Testing

- Tested empty name, email, and password fields
- Tested invalid email and short password
- Tested the mock signup tip
- Tested the simulated error and retry feature
- `flutter analyze` – No issues found
- `flutter test` – All tests passed
- Android release APK – Build successful


## Reflection – Undergraduate Track

**Question 1: Trace the AI tip feature from button tap to displayed text.**

When the user clicks the Get Practice Tip button, the app shows a loading indicator. After two seconds, the mock service returns a signup tip and displays it on the screen. If something goes wrong, the app shows an error message and a Retry button.

**Question 2: Why must the app keep form validation local even when it can ask an AI for a suggestion?**

Local validation is faster because the app can check user input without using a server. It also helps protect personal information like passwords and email addresses. Even if the AI service is not working, the form can still check the user's information.

## Contribution

[Describe the parts you personally implemented and tested.]

## Build Instructions

Run the app:

```bash
flutter run
```

Check the code:

```bash
flutter analyze
flutter test
```

Build the Android APK:

```bash
flutter build apk --release
```

APK location:

`build/app/outputs/flutter-apk/app-release.apk`

## Limitations

This project uses a local mock service instead of a live AI model. The signup form only checks user input and does not create a real account.
