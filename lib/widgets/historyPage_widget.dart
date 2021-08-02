import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/extensions/extensions.dart';

import 'package:qr_reader/providers/providers.dart';

class HistoryPage extends StatelessWidget {
  final String type;
  final Color dismissColor;

  const HistoryPage({Key? key, required this.type, required this.dismissColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final list = scanListProvider.list;

    final leadingIcon = this.type == 'geo' ? Icons.map : Icons.http_outlined;

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, i) => Dismissible(
        background: Container(
          color: dismissColor,
        ),
        onDismissed: (DismissDirection dismissDirection) {
          Provider.of<ScanListProvider>(context, listen: false)
              .deleteScanById(list[i].id!);
        },
        key: Key(list[i].id.toString() + 'mph'),
        child: ListTile(
          leading: Icon(
            leadingIcon,
            color: Theme.of(context).primaryColor,
          ),
          title: Text('${list[i].value}'),
          subtitle: Text('ID: ${list[i].id}'),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () => list[i].launchUrl(context),
        ),
      ),
    );
  }
}
