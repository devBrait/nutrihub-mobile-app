import 'package:flutter_test/flutter_test.dart';
import 'package:nutrihub_app/app/app.dart';

void main() {
  testWidgets('App renders without error', (WidgetTester tester) async {
    await tester.pumpWidget(const NutriHubApp());
    expect(find.byType(NutriHubApp), findsOneWidget);
  });
}
