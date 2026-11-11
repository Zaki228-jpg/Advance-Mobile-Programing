import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_seven_lab/main.dart';

void main() {
  testWidgets('shows GestureDetector and InkWell examples', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('GestureDetector'), findsOneWidget);
    expect(find.text('InkWell'), findsOneWidget);
    expect(
      find.textContaining('InkWell provides Material feedback'),
      findsOneWidget,
    );
  });

  testWidgets('single taps change each card color', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    Color gestureColor() {
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byKey(const Key('gesture-card')),
          matching: find.byType(Container),
        ),
      );
      return (container.decoration! as BoxDecoration).color!;
    }

    Color? inkWellColor() {
      return tester
          .widget<Material>(
            find
                .ancestor(
                  of: find.byKey(const Key('inkwell-card')),
                  matching: find.byType(Material),
                )
                .first,
          )
          .color;
    }

    final oldGestureColor = gestureColor();
    await tester.tap(find.byKey(const Key('gesture-card')));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(gestureColor(), isNot(oldGestureColor));

    final oldInkWellColor = inkWellColor();
    await tester.tap(find.byKey(const Key('inkwell-card')));
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(inkWellColor(), isNot(oldInkWellColor));
  });

  testWidgets('double taps toggle favorite icons', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const Key('gesture-card')));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(find.byKey(const Key('gesture-card')));
    await tester.pumpAndSettle();
    expect(
      tester.widget<Icon>(find.byKey(const Key('gesture-favorite'))).icon,
      Icons.favorite,
    );

    await tester.tap(find.byKey(const Key('inkwell-card')));
    await tester.pump(const Duration(milliseconds: 50));
    await tester.tap(find.byKey(const Key('inkwell-card')));
    await tester.pumpAndSettle();
    expect(
      tester.widget<Icon>(find.byKey(const Key('inkwell-favorite'))).icon,
      Icons.favorite,
    );
  });

  testWidgets('long press and visible button open item actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final card = find.byKey(const Key('long-press-card'));
    await tester.ensureVisible(card);
    await tester.longPress(card);
    await tester.pumpAndSettle();

    expect(find.text('Add to favorites'), findsOneWidget);
    expect(find.text('Archive item'), findsOneWidget);
    expect(find.text('Share item'), findsOneWidget);

    await tester.tap(find.text('Add to favorites'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Added to favorites'), findsOneWidget);
    expect(
      tester.widget<Icon>(find.byKey(const Key('item-state-icon'))).icon,
      Icons.favorite,
    );

    final actionsButton = find.byKey(const Key('item-actions-button'));
    await tester.ensureVisible(actionsButton);
    await tester.tap(actionsButton);
    await tester.pumpAndSettle();
    expect(find.text('Remove from favorites'), findsOneWidget);
  });
}
