import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime transactionDate;

  Transaction({
    @required this.title,
    @required this.amount,
    @required this.transactionDate,
    @required this.id,
  });
}
