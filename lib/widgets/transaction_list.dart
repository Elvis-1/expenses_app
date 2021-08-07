import 'package:expenses_app/widgets/transaction_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';



class TransactionList extends StatelessWidget {
  //const TransactionList({Key? key}) : super(key: key);
 final List<Transaction> transaction;
 final Function deleteTx;
 TransactionList(this.transaction, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty ?
    LayoutBuilder(builder: (ctx,constraints){
      return  Column(
        children: [
          Text('No transactions yet', style: Theme.of(context).textTheme.title),
          SizedBox(
            height:20,
          ),
          Container(
              height:constraints.maxHeight*0.6,
              child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,)),
        ],
      );
    }):

       ListView.builder(
        itemBuilder: (ctx, index){
          return TransactionItem(transaction: transaction[index], deleteTx: deleteTx);
          // return Card(
          //   child: Row(
          //     children: [
          //       Container(
          //         padding: EdgeInsets.all(10),
          //         margin:
          //         EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          //         decoration: BoxDecoration(
          //           border: Border.all(
          //             color: Theme.of(context).primaryColor,
          //             width: 2,
          //           ),
          //         ),
          //         child: Text(
          //           '\$ ${transactions[index].amount.toStringAsFixed(2)}',
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20,
          //             color: Theme.of(context).primaryColor,
          //           ),
          //         ),
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             transactions[index].title,
          //             //
          //             style: Theme.of(context).textTheme.title,
          //           ),
          //           // Text(DateFormat('yyyy-MM-dd').format(tx.date),
          //           Text(
          //             DateFormat.yMMMd().format(transactions[index].date),
          //             style: TextStyle(color: Colors.grey),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // );

        },
        itemCount: transaction.length,
      );

  }
}
