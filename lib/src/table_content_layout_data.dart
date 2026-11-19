import 'package:flutter/widgets.dart';

@immutable
class TableContentDividerData {
  final Color color;
  final Gradient? gradient;
  final double thickness;
  final double offset;
  final double? wiggleInterval;
  final int wiggleCount;
  final double wiggleOffset;

  const TableContentDividerData({
    required this.color,
    required this.gradient,
    required this.thickness,
    required this.offset,
    required this.wiggleInterval,
    required this.wiggleCount,
    required this.wiggleOffset,
  });

  bool get visible => gradient != null || color.a >= .003;

  @override
  bool operator ==(Object other) =>
      other is TableContentDividerData &&
      other.color == color &&
      other.gradient == gradient &&
      other.thickness == thickness &&
      other.offset == offset &&
      other.wiggleInterval == wiggleInterval &&
      other.wiggleCount == wiggleCount &&
      other.wiggleOffset == wiggleOffset;

  @override
  int get hashCode => Object.hash(
    color,
    gradient,
    thickness,
    offset,
    wiggleInterval,
    wiggleCount,
    wiggleOffset,
  );
}

@immutable
class TableContentColumnData {
  final List<int> indices;
  final List<double> positions;
  final List<double> widths;
  final List<Key> keys;

  const TableContentColumnData({
    required this.indices,
    required this.positions,
    required this.widths,
    required this.keys,
  });
}

/// An immutable storage class that contains horizontal layout information of
/// a table.
@immutable
class TableContentLayoutData {
  final TableContentColumnData scrollableColumns, fixedColumns;
  final Key? foregroundColumnKey;

  final TableContentDividerData leftDivider, rightDivider;
  final double leftWidth, centerWidth, rightWidth;

  final bool fixedRowHeight;
  final TextDirection textDirection;

  const TableContentLayoutData({
    required this.scrollableColumns,
    required this.fixedColumns,
    required this.foregroundColumnKey,
    required this.leftDivider,
    required this.rightDivider,
    required this.leftWidth,
    required this.centerWidth,
    required this.rightWidth,
    required this.fixedRowHeight,
    required this.textDirection,
  });
}
