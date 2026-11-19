# material_table_view example

This example demonstrates the package on iOS, Android, macOS and other Flutter
platforms. It includes a regular `TableView` and a `SliverTableView` with
frozen columns, horizontal scrolling, lazy row building and row interaction.

From the repository root:

```shell
cd example
flutter pub get
flutter run -d ios
```

To run on a booted iOS Simulator, use its device id from `flutter devices`:

```shell
flutter run -d <device-id>
```

The package is referenced through `path: ..`, so changes to the library are
available to the example immediately during development.
