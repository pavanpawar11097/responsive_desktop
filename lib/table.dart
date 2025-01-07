import 'package:flutter/material.dart';
import 'package:responsive_desktop/main.dart';

class TableShow extends StatelessWidget {
  const TableShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
        border: TableBorder.all(), // Adds borders around the cells
        children: [
          TableRow(children: [
            commonRow(context, title: 'Row 1, Col 1'),
            commonRow(context, title: 'Row 1, Col 2'),
            commonRow(context, title: 'Row 1, Col 3'),
            commonRow(context, title: 'Row 1, Col 4'),
            commonRow(context, title: 'Row 1, Col 5'),
          ]),
          TableRow(children: [
            commonRow(context, title: 'Row 2, Col 3'),
            commonRow(context, title: 'Row 2, Col 4'),
            commonRow(context, title: 'Row 2, Col 2'),
            commonRow(context, title: 'Row 2, Col 1'),
            commonRow(context, title: 'Row 2, Col 5'),
          ]),
          TableRow(children: [
            commonRow(context, title: 'Row 3, Col 1'),
            commonRow(context, title: 'Row 3, Col 2'),
            commonRow(context, title: 'Row 3, Col 3'),
            commonRow(context, title: 'Row 3, Col 4'),
            commonRow(context, title: 'Row 3, Col 5'),
          ]),
        ]);
  }

  Widget commonRow(BuildContext context, {String title = ''}) {
    return TableCell(
        child: Padding(
      padding: const EdgeInsets.all(2),
      child: Center(
          child: Text(title,
              style: TextStyle(fontSize: getResponsiveFontSize(context)))),
    ));
  }
}
