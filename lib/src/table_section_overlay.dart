import 'package:flutter/widgets.dart';

class TableSectionOverlay extends StatefulWidget {
  final Widget child;

  const TableSectionOverlay({super.key, required this.child});

  @override
  State<TableSectionOverlay> createState() => _TableSectionOverlayState();
}

class _TableSectionOverlayState extends State<TableSectionOverlay> {
  late final OverlayEntry _entry = OverlayEntry(
    canSizeOverlay: true,
    maintainState: true,
    builder: (context) => widget.child,
  );

  @override
  void didUpdateWidget(covariant TableSectionOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!identical(widget.child, oldWidget.child)) {
      _entry.markNeedsBuild();
    }
  }

  @override
  Widget build(BuildContext context) =>
      Overlay(clipBehavior: Clip.none, initialEntries: [_entry]);
}
