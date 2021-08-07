import 'dart:io';

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

  bool _showChart = false;



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
Widget _buildLandScapeContent(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Show Chart'),
        Switch.adaptive(value: _showChart, onChanged:(val){
          setState(() {
            _showChart = val;
          });

        }),
      ],
    );
}

Widget _buildPortraitContent(MediaQueryData mediaquery, PreferredSizeWidget appBar){
  return  Container(
      height: (
          mediaquery
              .size
              .height - appBar.preferredSize.height - MediaQuery
              .of(context)
              .padding
              .top) * 0.3,
      child: Chart(_recentTransactions));
}

  // PreferredSize(
  // preferredSize: Size.fromHeight(100.0),
  // child: _anyWidget
  // )

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final isLandScape = mediaquery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar =  (Platform.isIOS? CupertinoNavigationBar(middle: Text('Expenses App'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [IconButton(
      icon:Icon(Icons.add),
      onPressed:()=> _startAddNewTransaction(context),
    ),],),
    ) : AppBar(title: Text('Expenses App'),
      actions: [
        IconButton(
          icon:Icon(Icons.add),
          onPressed:()=> _startAddNewTransaction(context),
        ),

      ],
    ))as PreferredSizeWidget;


    final txListWidget = Container(
      height: (mediaquery.size.height - appBar.preferredSize.height - mediaquery.padding.top)*0.7,
      child: TransactionList(_userTransaction, _deleteTransaction),);

    final pageBody = SafeArea(
      child:SingleChildScrollView(
      child: Column(
        //mainAxisAlignment:MainAxisAlignment.spaceAround,
        children: [
          if(isLandScape) _buildLandScapeContent(),
          if(!isLandScape) _buildPortraitContent(mediaquery,appBar),
          if(!isLandScape) txListWidget,
          if(isLandScape) _showChart ? Container(
              height: (
                  mediaquery
                      .size
                      .height - appBar.preferredSize.height - MediaQuery
                      .of(context)
                      .padding
                      .top) * 0.7,
              child: Chart(_recentTransactions))

              :txListWidget
        ],
      ),
    ));

    return Platform.isIOS? CupertinoPageScaffold(
        child: pageBody,
    navigationBar: appBar as ObstructingPreferredSizeWidget,
    ): Scaffold (
      appBar:appBar,
      body:pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> _startAddNewTransaction(context),
      ),
    );
  }
}
