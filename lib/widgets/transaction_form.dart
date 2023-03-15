import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function submitHandler;

  TransactionForm(this.submitHandler);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty ||
        _titleController.text.isEmpty ||
        _selectedDate == null) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredAmount <= 0) {
      return;
    }

    widget.submitHandler(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No date chosen'
                              : 'Picked date: ${DateFormat.yMMMd().format(_selectedDate)}',
                        ),
                      ),
                      TextButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          'Choose date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitData,
                  child: Text('Add transaction'),
                  style: Theme.of(context).elevatedButtonTheme.style,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
