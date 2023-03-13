import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_form.dart';
import 'widgets/transactions_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      primarySwatch: Colors.purple,
      fontFamily: 'Quicksand',
      textTheme: ThemeData.light().textTheme.copyWith(
            titleLarge: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
        ),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.amber,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   transactionDate: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly groceries',
    //   amount: 15.65,
    //   transactionDate: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.transactionDate.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    setState(() {
      _userTransactions.add(new Transaction(
        title: title,
        amount: amount,
        transactionDate: chosenDate,
        id: DateTime.now().toString(),
      ));
    });
  }

  void _showTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: TransactionForm(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
            onPressed: () => _showTransactionForm(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTransactionForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
