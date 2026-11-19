import 'package:material_ui/material_ui.dart';
import 'package:material_table_view/src/table_view_style_resolved.dart';

class TableHorizontalDivider extends StatelessWidget {
  final ResolvedTableViewHorizontalDividerStyle style;

  const TableHorizontalDivider({super.key, required this.style});

  @override
  Widget build(BuildContext context) {
    final gradient = style.gradient;
    if (gradient == null) {
      return Divider(
        height: style.space,
        thickness: style.thickness,
        color: style.color,
        endIndent: style.endIndent,
        indent: style.indent,
        radius: style.radius,
      );
    }

    final thickness = style.thickness == .0
        ? 1 / MediaQuery.devicePixelRatioOf(context)
        : style.thickness;

    return SizedBox(
      height: style.space,
      child: Center(
        child: Container(
          height: thickness,
          margin: EdgeInsetsDirectional.only(
            start: style.indent,
            end: style.endIndent,
          ),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: style.radius,
          ),
        ),
      ),
    );
  }
}
