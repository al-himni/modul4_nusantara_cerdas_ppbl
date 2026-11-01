import 'package:flutter_test/flutter_test.dart';

import 'package:nusantara_cerdas_modul4/main.dart';

void main() {
  testWidgets('Nusantara Cerdas Mobile dapat berjalan', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NusantaraCerdasMobile());

    expect(find.text('Rincian Layanan'), findsOneWidget);
  });
}
