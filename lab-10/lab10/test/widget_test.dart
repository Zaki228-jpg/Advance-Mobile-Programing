import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab10/main.dart';

void main() {
  testWidgets('button animates the container properties', (tester) async {
    await tester.pumpWidget(const AnimatedContainerLabApp());

    AnimatedContainer container() => tester.widget<AnimatedContainer>(
      find.byKey(const ValueKey('animated-square')),
    );

    expect(find.text('Watch the box change'), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const ValueKey('animated-square'))),
      const Size(120, 120),
    );
    expect(container().duration, const Duration(milliseconds: 800));
    expect((container().decoration as BoxDecoration).color, Colors.blue);

    await tester.tap(find.byKey(const ValueKey('toggle-button')));
    await tester.pumpAndSettle();

    expect(
      tester.getSize(find.byKey(const ValueKey('animated-square'))),
      const Size(200, 170),
    );
    expect((container().decoration as BoxDecoration).color, Colors.orange);
    expect(
      (container().decoration as BoxDecoration).borderRadius,
      BorderRadius.circular(40),
    );
    expect(find.text('Make it small'), findsOneWidget);
  });

  testWidgets('duration choices update the UX explanation', (tester) async {
    await tester.pumpWidget(const AnimatedContainerLabApp());

    await tester.ensureVisible(find.byType(DropdownButton<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DropdownButton<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fast (300 ms)').last);
    await tester.pumpAndSettle();

    expect(find.textContaining('snappy'), findsOneWidget);
  });

  testWidgets('Lab 2 keeps opacity layout and crossfades lock states', (
    tester,
  ) async {
    await tester.pumpWidget(const AnimatedContainerLabApp());
    await tester.tap(find.text('Lab 2 · Profile'));
    await tester.pumpAndSettle();

    final opacityFinder = find.byKey(const ValueKey('profile-opacity'));
    final crossFadeFinder = find.byKey(const ValueKey('profile-crossfade'));
    final profileSize = tester.getSize(opacityFinder);

    await tester.tap(find.byKey(const ValueKey('opacity-button')));
    await tester.pumpAndSettle();

    expect(tester.widget<AnimatedOpacity>(opacityFinder).opacity, 0);
    expect(tester.getSize(opacityFinder), profileSize);
    expect(find.text('Show profile'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const ValueKey('crossfade-button')));
    await tester.pumpAndSettle();
    final buttonTopWhenLocked = tester
        .getTopLeft(find.byKey(const ValueKey('crossfade-button')))
        .dy;
    await tester.tap(find.byKey(const ValueKey('crossfade-button')));
    await tester.pumpAndSettle();

    expect(
      tester.widget<AnimatedCrossFade>(crossFadeFinder).crossFadeState,
      CrossFadeState.showSecond,
    );
    expect(
      tester.getTopLeft(find.byKey(const ValueKey('crossfade-button'))).dy,
      greaterThan(buttonTopWhenLocked),
    );
    expect(find.text('Lock profile'), findsOneWidget);
  });
}
