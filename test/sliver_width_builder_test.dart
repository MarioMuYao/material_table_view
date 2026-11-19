import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_table_view/src/sliver_width_builder.dart';

void main() {
  testWidgets(
    'does not rebuild the child when only the sliver scroll offset changes',
    (tester) async {
      var childBuildCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              SliverCrossAxisExtentBuilder(
                builder: (context, crossAxisExtent) {
                  childBuildCount++;
                  return SliverToBoxAdapter(
                    child: SizedBox(width: crossAxisExtent, height: 2000),
                  );
                },
              ),
            ],
          ),
        ),
      );
      await tester.pump();

      expect(childBuildCount, 1);

      await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
      await tester.pumpAndSettle();

      expect(childBuildCount, 1);
    },
  );

  testWidgets('rebuilds the cached child when the builder changes', (
    tester,
  ) async {
    var label = 'first';
    late StateSetter update;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            update = setState;
            return CustomScrollView(
              slivers: [
                SliverCrossAxisExtentBuilder(
                  builder: (context, crossAxisExtent) => SliverToBoxAdapter(
                    child: SizedBox(
                      width: crossAxisExtent,
                      height: 200,
                      child: Text(label),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

    expect(find.text('first'), findsOneWidget);

    update(() => label = 'second');
    await tester.pump();

    expect(find.text('second'), findsOneWidget);
  });
}
