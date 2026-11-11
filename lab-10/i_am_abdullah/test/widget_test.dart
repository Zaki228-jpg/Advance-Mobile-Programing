import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i_am_abdullah/main.dart';

void main() {
  testWidgets('shows the collection title, image, and subtitle', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const IAmRichApp());

    expect(find.text('I Am Rich'), findsOneWidget);
    expect(find.text('My Collection'), findsOneWidget);

    final image = tester.widget<Image>(find.byType(Image));
    expect(image.fit, BoxFit.contain);
  });

  testWidgets('fits on a small phone screen', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const IAmRichApp());

    expect(tester.takeException(), isNull);
  });
}
