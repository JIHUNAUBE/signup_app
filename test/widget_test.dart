
import 'package:flutter_test/flutter_test.dart';
import 'package:signup_app/main.dart';

void main() {
  testWidgets('Practice form displays correctly', (tester) async {
    await tester.pumpWidget(const PracticeApp());

    expect(find.text('Create Your Profile'), findsOneWidget);
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Check Form'), findsOneWidget);
    expect(find.text('Get Practice Tip'), findsOneWidget);
  });

  testWidgets('Empty form shows validation errors', (tester) async {
    await tester.pumpWidget(const PracticeApp());

    await tester.tap(find.text('Check Form'));
    await tester.pump();

    expect(find.text('Please enter your name'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter a password'), findsOneWidget);
  });
}
