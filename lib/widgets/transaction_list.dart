import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> userTransactions;
  final Function deleteTransactions;

  TransactionList(this.userTransactions, this.deleteTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: userTransactions.isEmpty
          ? Container(
              height: 300,
              child: Column(
                children: [
                  Text(
                    'We have No transactions yet',
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            )
          : ListView(children: [
              Column(
                children: userTransactions
                    .map((x) => Card(
                          elevation: 6,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Text(
                                  //For accepting the 2 digits after  decimal places
                                  "\$${x.amount.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  border: Border.all(
                                      color: Theme.of(context).primaryColorDark,
                                      width: 2,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: EdgeInsets.all(10),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(
                                    x.title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  Container(
                                    child: Text(
                                      //Acess to special Constructor
                                      //Format of the date
                                      DateFormat.yMMMMd().format(x.date),
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => deleteTransactions(x.id),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ]),
    );
  }
}
