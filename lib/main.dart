import 'package:flutter/material.dart';
import 'package:personal_expense/widgets/new_transaction.dart';
import 'package:personal_expense/widgets/transaction_list.dart';
import './widgets/transaction_list.dart';
import './models/transactions.dart';
import './widgets/charts.dart';
import 'package:flutter/services.dart';

void main() {
  //This method  don't allows the potrait mode for the application but it  requires the servie.dart pkg

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitUp,
  ]);

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

//Adding the new trasnaction to list
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

// Inititating the new transaction
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
    final availHeight = MediaQuery.of(context).size.height;

    //This  method is inside the build method because it needs the context objects
    final appBar = AppBar(
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
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: (availHeight -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.3,
                    child: Chart(recentTransaction)),
                Container(
                    height: (availHeight -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    child:
                        TransactionList(userTransactions, deleteTrasnaction)),
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
