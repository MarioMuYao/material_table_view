import 'package:flutter/widgets.dart';

/// Holds properties to enable row reordering in a table.
class TableRowReorder {
  /// See [SliverReorderableList.findChildIndexCallback].
  final ChildIndexGetter? findChildIndexCallback;

  /// Callback using the legacy insertion-index semantics.
  ///
  /// Prefer [onReorderItem] for the current Flutter semantics.
  @Deprecated(
    'Use onReorderItem instead. This callback uses the legacy insertion-index semantics.',
  )
  final ReorderCallback? onReorder;

  /// See [SliverReorderableList.onReorderItem].
  final ReorderCallback? onReorderItem;

  /// See [SliverReorderableList.onReorderStart].
  final void Function(int)? onReorderStart;

  /// See [SliverReorderableList.onReorderEnd].
  final void Function(int)? onReorderEnd;

  /// See [SliverReorderableList.proxyDecorator].
  final ReorderItemProxyDecorator? proxyDecorator;

  /// See [SliverReorderableList.autoScrollerVelocityScalar].
  final double? autoScrollerVelocityScalar;

  TableRowReorder({
    this.onReorder,
    this.onReorderItem,
    this.onReorderStart,
    this.onReorderEnd,
    this.findChildIndexCallback,
    this.proxyDecorator,
    this.autoScrollerVelocityScalar,
  }) : assert(
         (onReorder == null) != (onReorderItem == null),
         'Exactly one of onReorder or onReorderItem must be provided.',
       );
}
