import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_table_view/material_table_view.dart';
import 'package:material_table_view/sliver_table_view.dart';
import 'package:material_table_view/src/table_section_overlay.dart';
import 'package:material_table_view/src/table_content_layout.dart';

class _KeyedTableColumn extends TableColumn {
  const _KeyedTableColumn({required this.columnKey, required super.width});

  final Key columnKey;

  @override
  Key get key => columnKey;
}

void main() {
  testWidgets('calls placeholderRowBuilder for each placeholder row', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          height: 160,
          width: 240,
          child: TableView.builder(
            columns: const [TableColumn(width: 200)],
            rowCount: 2,
            rowHeight: 48,
            rowBuilder: (context, row, contentBuilder) => null,
            placeholderRowBuilder: (context, row, contentBuilder) =>
                contentBuilder(
                  context,
                  (context, column) => Text('placeholder $row'),
                ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.text('placeholder 0'), findsOneWidget);
    expect(find.text('placeholder 1'), findsOneWidget);
  });

  testWidgets('supports dynamic row extents in SliverTableView', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CustomScrollView(
          slivers: [
            SliverTableView.builder(
              columns: const [TableColumn(width: 200)],
              rowCount: 2,
              rowHeight: null,
              rowHeightBuilder: (index, dimensions) => 40 + index * 8,
              rowBuilder: (context, row, contentBuilder) => contentBuilder(
                context,
                (context, column) => Text('row $row'),
              ),
            ),
          ],
        ),
      ),
    );
    await tester.pump();

    expect(find.text('row 0'), findsOneWidget);
  });

  test('preserves wiggle interval in divider style transformations', () {
    const original = TableViewVerticalDividerStyle(
      wiggleInterval: 20,
      offset: 4,
    );
    const changed = TableViewVerticalDividerStyle(
      wiggleInterval: 40,
      offset: 8,
    );

    expect(original.copyWith().wiggleInterval, 20);
    expect(original.lerp(changed, .5).wiggleInterval, 30);
    expect(original.copyWith().offset, 4);
    expect(original.lerp(changed, .5).offset, 6);
  });

  test('preserves a column key through copyWith', () {
    const key = ValueKey('column');
    const original = _KeyedTableColumn(columnKey: key, width: 80);

    expect(original.copyWith(width: 120).key, same(key));
  });

  test('lerps horizontal divider enabled state', () {
    const disabled = TableViewHorizontalDividerStyle(enabled: false);
    const enabled = TableViewHorizontalDividerStyle(enabled: true);

    expect(disabled.lerp(enabled, 0).enabled, isFalse);
    expect(disabled.lerp(enabled, 1).enabled, isTrue);
  });

  testWidgets('clamps the body when fixed sections exceed the viewport', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 240,
          height: 40,
          child: TableView.builder(
            columns: const [TableColumn(width: 200)],
            rowCount: 1,
            rowHeight: 24,
            headerHeight: 48,
            footerHeight: 48,
            headerBuilder: (context, contentBuilder) =>
                contentBuilder(context, (context, column) => const SizedBox()),
            footerBuilder: (context, contentBuilder) =>
                contentBuilder(context, (context, column) => const SizedBox()),
            rowBuilder: (context, row, contentBuilder) =>
                contentBuilder(context, (context, column) => const SizedBox()),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('updates the row overlay when its child changes', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: TableSectionOverlay(child: Text('old child'))),
    );
    expect(find.text('old child'), findsOneWidget);

    await tester.pumpWidget(
      const MaterialApp(home: TableSectionOverlay(child: Text('new child'))),
    );

    expect(find.text('old child'), findsNothing);
    expect(find.text('new child'), findsOneWidget);
  });

  testWidgets('updates vertical divider gradient colors', (tester) async {
    var colors = const [Colors.red, Colors.blue];
    late StateSetter update;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            update = setState;
            return SizedBox(
              width: 240,
              height: 120,
              child: TableView.builder(
                style: TableViewStyle(
                  dividers: TableViewDividersStyle(
                    vertical: TableViewVerticalDividersStyle(
                      leading: TableViewVerticalDividerStyle(
                        gradient: LinearGradient(colors: colors),
                        wiggleCount: 0,
                      ),
                    ),
                  ),
                ),
                columns: const [
                  TableColumn(width: 80, freezePriority: 100),
                  TableColumn(width: 160),
                ],
                rowCount: 1,
                rowHeight: 48,
                rowBuilder: (context, row, contentBuilder) => contentBuilder(
                  context,
                  (context, column) => const SizedBox.expand(),
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.pump();

    TableContentLayoutState layoutState() =>
        tester.state<TableContentLayoutState>(find.byType(TableContentLayout));

    List<double> gradientRedValues() =>
        (layoutState().lastLayoutData.leftDivider.gradient! as LinearGradient)
            .colors
            .map((color) => color.r)
            .toList();

    expect(gradientRedValues(), colors.map((color) => color.r).toList());

    update(() => colors = const [Colors.green, Colors.yellow]);
    await tester.pump();

    expect(gradientRedValues(), colors.map((color) => color.r).toList());
  });

  test('preserves and interpolates divider gradients', () {
    const originalGradient = LinearGradient(
      colors: [Colors.transparent, Colors.black26],
    );
    const changedGradient = LinearGradient(
      colors: [Colors.transparent, Colors.teal],
    );
    const original = TableViewVerticalDividerStyle(gradient: originalGradient);
    const changed = TableViewVerticalDividerStyle(gradient: changedGradient);

    expect(original.copyWith().gradient, same(originalGradient));
    expect(original.lerp(changed, .5).gradient, isA<LinearGradient>());
    expect(original == changed, isFalse);
  });
}
