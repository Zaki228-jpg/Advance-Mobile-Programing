import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasbih_counter/main.dart';

void main() {
  testWidgets('counter increases and reset returns it to zero', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TasbihApp());

    expect(find.text('Tasbih Counter'), findsOneWidget);
    expect(find.text('0 / 33'), findsOneWidget);

    await tester.tap(find.byKey(const Key('countButton')));
    await tester.pump();
    expect(find.text('1 / 33'), findsOneWidget);

    final Finder resetButton = find.byKey(const Key('resetButton'));
    await tester.ensureVisible(resetButton);
    await tester.pumpAndSettle();
    await tester.tap(resetButton);
    await tester.pump();
    expect(find.text('0 / 33'), findsOneWidget);
  });

  testWidgets('target can be selected', (WidgetTester tester) async {
    await tester.pumpWidget(const TasbihApp());

    await tester.tap(find.byKey(const Key('target99')));
    await tester.pump();

    expect(find.text('0 / 99'), findsOneWidget);
  });

  testWidgets('completion message appears at the selected target', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TasbihApp());

    for (int tap = 0; tap < 33; tap++) {
      await tester.tap(find.byKey(const Key('countButton')));
    }
    await tester.pump();

    expect(find.text('33 / 33'), findsOneWidget);
    expect(find.text('Target completed!'), findsOneWidget);
  });
}
