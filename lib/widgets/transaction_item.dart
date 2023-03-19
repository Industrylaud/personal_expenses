import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteHandler,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteHandler;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('${transaction.amount}zł'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.transactionDate),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                onPressed: () => deleteHandler(transaction.id),
                style: Theme.of(context).textButtonTheme.style,
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              )
            : IconButton(
                color: Theme.of(context).errorColor,
                icon: const Icon(Icons.delete),
                onPressed: () => deleteHandler(transaction.id),
              ),
      ),
    );
  }
}
