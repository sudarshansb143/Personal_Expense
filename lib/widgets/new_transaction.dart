import 'dart:ffi';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class NewTransactions extends StatefulWidget {
  final Function addtx;

  NewTransactions({this.addtx});

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime _selectDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmt = double.parse(amountController.text);

    if (enteredAmt <= 0 || enteredTitle.isEmpty || _selectDate == null) {
      return;
    }
    widget.addtx(enteredTitle, enteredAmt, _selectDate);

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickDate) {
      if (pickDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (val) => {submitData()},
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (val) => {submitData()},
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 20,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectDate == null
                        ? "No Date Choose"
                        : "Picked Date :- ${DateFormat.yMd().format(_selectDate)}"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                    textColor: Colors.purple,
                    child: Text(
                      "Choose date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: presentDatePicker,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              onPressed: submitData,
              color: Colors.purple,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
