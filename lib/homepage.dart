import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';


class MyHomePage extends StatefulWidget {
  //const MyHomePage({Key? key}) : super(key: key);


  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 99.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2',
    //     title: 'Weekly Groceries',
    //     amount: 79.99,
    //     date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions{
    return  _userTransaction.where((tx){
      return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),),
      );
    }).toList();
  }
  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate){
    final newTx = Transaction(
        title :txTitle ,
        amount: txAmount,
        id: DateTime.now().toString(),
        date: chosenDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet<void>(context: ctx, builder: (_){
      return GestureDetector(
          onTap: (){},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction));
    },
    );
  }
  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((tx) {
        return  tx.id == id;
      } );
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar =  AppBar(title: Text('Expenses App'),
      actions: [
        IconButton(
          icon:Icon(Icons.add),
          onPressed:()=> _startAddNewTransaction(context),
        ),

      ],
    );
    return Scaffold(
      appBar:appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment:MainAxisAlignment.spaceAround,
          children: [
           Container(
               height: (
                   MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.3,
               child: Chart(_recentTransactions)),

  Container(
      height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top)*0.7,
      child: TransactionList(_userTransaction, _deleteTransaction))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> _startAddNewTransaction(context),
      ),
    );
  }
}
