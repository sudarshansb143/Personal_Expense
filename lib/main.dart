import 'package:flutter/material.dart';
import 'package:personal_expense/widgets/new_transaction.dart';
import 'package:personal_expense/widgets/transaction_list.dart';
import './widgets/transaction_list.dart';
import './models/transactions.dart';
import 'package:intl/intl.dart';
import './widgets/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Personal Expense",
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          scaffoldBackgroundColor: Colors.white,
          //Global appbar theme
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
//                    fontWeight: FontWeight.bold,
                  )))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
//method for showing the model
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> userTransactions = [];

//Generate recent trasnactions

  List<Transactions> get recentTransaction {
    return userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime selectedDate) {
    final tx = Transactions(
      amount: txAmount,
      date: selectedDate,
      id: 'tx' + DateTime.now().toString(),
      title: txTitle,
    );
    setState(() {
      userTransactions.add(tx);
    });
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransactions(
              addtx: _addTransaction,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

//Deleting transactions using id

  void deleteTrasnaction(String id) {
    setState(() {
      return userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Expense",
        ),
        actions: [
          //Buttion in action bar
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              startNewTransaction(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Chart(recentTransaction),
                TransactionList(userTransactions, deleteTrasnaction),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {startNewTransaction(context)},
      ),
    );
  }
}
