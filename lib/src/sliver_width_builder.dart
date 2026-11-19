import 'package:flutter/widgets.dart';

class SliverCrossAxisExtentBuilder extends StatefulWidget {
  const SliverCrossAxisExtentBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, double crossAxisExtent) builder;

  @override
  State<SliverCrossAxisExtentBuilder> createState() =>
      _SliverCrossAxisExtentBuilderState();
}

class _SliverCrossAxisExtentBuilderState
    extends State<SliverCrossAxisExtentBuilder> {
  double? crossAxisExtent;
  Widget? child;

  @override
  void didUpdateWidget(covariant SliverCrossAxisExtentBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!identical(widget.builder, oldWidget.builder)) {
      crossAxisExtent = null;
      child = null;
    }
  }

  @override
  Widget build(BuildContext context) => SliverLayoutBuilder(
    builder: (context, constraints) {
      final nextCrossAxisExtent = constraints.crossAxisExtent;
      final child = this.child;
      if (child == null || crossAxisExtent != nextCrossAxisExtent) {
        crossAxisExtent = nextCrossAxisExtent;
        return this.child = widget.builder(context, nextCrossAxisExtent);
      }

      return child;
    },
  );
}
