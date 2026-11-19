import 'package:material_ui/material_ui.dart';
import 'package:material_table_view/material_table_view.dart';
import 'package:material_table_view/sliver_table_view.dart';
import 'package:material_table_view/table_view_typedefs.dart';

void main() {
  runApp(const MaterialTableViewExampleApp());
}

class MaterialTableViewExampleApp extends StatelessWidget {
  const MaterialTableViewExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Table View',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true),
      home: const TableExamplesPage(),
    );
  }
}

class TableExamplesPage extends StatefulWidget {
  const TableExamplesPage({super.key});

  @override
  State<TableExamplesPage> createState() => _TableExamplesPageState();
}

class _TableExamplesPageState extends State<TableExamplesPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Table View'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                _selectedIndex == 0 ? 'TableView' : 'SliverTableView',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: const [RegularTableExample(), SliverTableExample()]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.table_rows_outlined),
            selectedIcon: Icon(Icons.table_rows),
            label: 'Table',
          ),
          NavigationDestination(
            icon: Icon(Icons.view_stream_outlined),
            selectedIcon: Icon(Icons.view_stream),
            label: 'Sliver',
          ),
        ],
      ),
    );
  }
}

class RegularTableExample extends StatelessWidget {
  const RegularTableExample({super.key});

  static const _rowCount = 1000;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Virtualized table', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            'The first column stays visible while the other columns scroll horizontally.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _DataTable(
              table: TableView.builder(
                style: _exampleTableStyle,
                columns: _columns,
                rowCount: _rowCount,
                rowHeight: 56,
                headerHeight: 52,
                headerBuilder: _headerBuilder,
                rowBuilder: _rowBuilder,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverTableExample extends StatelessWidget {
  const SliverTableExample({super.key});

  static const _rowCount = 200;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            children: <Widget>[
              Text('SliverTable' * 100, style: Theme.of(context).textTheme.headlineMedium),
              Positioned(
                top: 0,
                bottom: 0,
                left: 24,
                child: Container(
                  width: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0x00F2F3F5), Color(0x80F2F3F5)],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          sliver: SliverToBoxAdapter(child: Text('Sliver composition', style: Theme.of(context).textTheme.titleLarge)),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text(
              'This table shares one vertical scroll position with the content above it.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverTableView.builder(
            style: _exampleTableStyle,
            columns: _columns,
            rowCount: _rowCount,
            rowHeight: 56,
            headerHeight: 52,
            headerBuilder: _headerBuilder,
            rowBuilder: _rowBuilder,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverTableView.builder(
            style: _exampleTableStyle,
            columns: _columns,
            rowCount: 3,
            rowHeight: 56,
            headerHeight: 52,
            headerBuilder: _headerBuilder,
            rowBuilder: _rowBuilder,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}

const _columns = [
  TableColumn(width: 112, freezePriority: 100),
  TableColumn(width: 128),
  TableColumn(width: 156),
  TableColumn(width: 132),
  TableColumn(width: 144),
  TableColumn(width: 128),
];

TableViewStyle get _exampleTableStyle => TableViewStyle(
  dividers: TableViewDividersStyle(
    horizontal: const TableViewHorizontalDividersStyle.symmetric(
      TableViewHorizontalDividerStyle(
        gradient: LinearGradient(colors: [Colors.transparent, Colors.teal, Colors.transparent]),
        thickness: 2,
        space: 2,
      ),
    ),
    vertical: TableViewVerticalDividersStyle(
      leading: TableViewVerticalDividerStyle(
        gradient: const LinearGradient(
          colors: [Colors.red, Colors.teal],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        thickness: 20,
        offset: 20,
        wiggleCount: 0,
        wiggleOffset: 0,
      ),
      trailing: TableViewVerticalDividerStyle(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.teal],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        thickness: 2,
        offset: 8,
        wiggleCount: 0,
      ),
    ),
  ),
);

Widget _headerBuilder(BuildContext context, TableRowContentBuilder contentBuilder) {
  return contentBuilder(context, (context, column) => _TableCell(label: _headers[column], isHeader: true));
}

Widget? _rowBuilder(BuildContext context, int row, TableRowContentBuilder contentBuilder) {
  // Kept to compare row BuildContext reuse between SliverList and SliverTableView.
  // ignore: avoid_print
  print('=========$context');
  return Material(
    key: ValueKey('row-$row'),
    type: MaterialType.transparency,
    child: InkWell(
      onTap: () => ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Selected row ${row + 1}'), duration: const Duration(milliseconds: 700))),
      child: contentBuilder(
        context,
        (context, column) => _TableCell(label: _cellValue(row, column), isLeading: column == 0),
      ),
    ),
  );
}

class _DataTable extends StatelessWidget {
  const _DataTable({required this.table});

  final Widget table;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(8), child: table),
    );
  }
}

class _TableCell extends StatelessWidget {
  const _TableCell({required this.label, this.isHeader = false, this.isLeading = false});

  final String label;
  final bool isHeader;
  final bool isLeading;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // color: isLeading && !isHeader ? colorScheme.surfaceContainerLow : Colors.transparent,
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: isHeader ? Theme.of(context).textTheme.labelLarge?.copyWith(color: colorScheme.onSurfaceVariant) : null,
      ),
    );
  }
}

const _headers = ['ID', 'Name', 'Status', 'Updated', 'Owner', 'Region'];

String _cellValue(int row, int column) {
  const statuses = ['Ready', 'Review', 'Blocked', 'Ready'];
  const owners = ['Ava', 'Noah', 'Mia', 'Liam'];
  const regions = ['US', 'EU', 'APAC', 'LATAM'];

  switch (column) {
    case 0:
      return '#${(row + 1).toString().padLeft(4, '0')}';
    case 1:
      return 'Record ${row + 1}';
    case 2:
      return statuses[row % statuses.length];
    case 3:
      return 'Nov ${18 - row % 12}, 2026';
    case 4:
      return owners[row % owners.length];
    case 5:
      return regions[row % regions.length];
    default:
      return '';
  }
}
