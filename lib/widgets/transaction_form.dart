import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function submitHandler;

  TransactionForm(this.submitHandler);

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    submitHandler(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                onSubmitted: (_) => submitData(),
              ),
              TextButton(
                onPressed: submitData,
                child: Text(
                  'Add transaction',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
