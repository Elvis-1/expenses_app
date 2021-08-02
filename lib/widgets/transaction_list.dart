import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';



class TransactionList extends StatelessWidget {
  //const TransactionList({Key? key}) : super(key: key);
 final List<Transaction> transactions;
 final Function deleteTx;
 TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? Column(
        children: [
           Text('No transactions yet', style: Theme.of(context).textTheme.title),
          SizedBox(
            height:20,
          ),
          Container(
              height: 200,
              child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,)),
        ],
      ):
       ListView.builder(
        itemBuilder: (ctx, index){
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
         return Card(
           elevation: 5,
           margin: EdgeInsets.symmetric(
             vertical: 8,
             horizontal: 5,
           ),
           child: ListTile(
             leading: CircleAvatar(
               radius: 30,
             child:Padding(
               padding: EdgeInsets.all(6),
               child: Container(
                 height: 20,
                 child: FittedBox(
                     child: Text('\$${transactions[index].amount}')),
               ),
             ),
             ),
             title:Text(transactions[index].title, style: Theme.of(context).textTheme.title,),
             subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
             trailing: IconButton(icon: const Icon(Icons.delete),
             color:Theme.of(context).errorColor,
               onPressed: ()=> deleteTx(transactions[index].id),
             ),
           ),
         );
        },
        itemCount: transactions.length,
      );

  }
}
