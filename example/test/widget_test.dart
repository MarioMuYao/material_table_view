import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_table_view_example/main.dart';

void main() {
  testWidgets('shows the regular table example', (tester) async {
    await tester.pumpWidget(const MaterialTableViewExampleApp());

    expect(find.text('Virtualized table'), findsOneWidget);
    expect(find.text('ID'), findsOneWidget);
    expect(find.text('#0001'), findsOneWidget);
  });

  testWidgets('switches to the sliver table example', (tester) async {
    await tester.pumpWidget(const MaterialTableViewExampleApp());

    await tester.tap(find.text('Sliver'));
    await tester.pumpAndSettle();

    expect(find.byType(CustomScrollView), findsOneWidget);
  });
}
