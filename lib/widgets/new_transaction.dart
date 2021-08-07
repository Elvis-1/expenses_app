import 'dart:io';
import 'package:expenses_app/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //const NewTransaction({Key? key}) : super(key: key);
 final Function addTx;
 NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();


  DateTime _selectedDate;

 void _submitData(){
   if(_amountController.text.isEmpty){
     return;
   }
   final enteredTitle = _titleController.text;
   final enteredAmount = double.parse(_amountController.text);

   if(enteredTitle.isEmpty || enteredAmount<=0 || _selectedDate == null){
     return;
   }
   widget.addTx(
   enteredTitle,
   enteredAmount,
       _selectedDate
   );

   Navigator.of(context).pop(); // to return the pop up once we click modal
 }
   void _presentDatePicker(){
   showDatePicker(context: context,
       initialDate: DateTime.now(),
       firstDate:DateTime(2021),
       lastDate: DateTime.now(),
   ).then((pickedDate){
     if(pickedDate == null) {
       return;
     }
     setState((){
       _selectedDate = pickedDate;
     });

   });

   }


 @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Card(
        elevation:5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            //bottom: 10
            bottom: MediaQuery.of(context).viewInsets.bottom + 10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //CupertinoTextField() -- You can also use cupertino text field if you are not comfortable with the material textfield

              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted:(_) => _submitData(),
                // onChanged: (val){
                //   titleInput = val;
                // },

              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                // onChanged: (val)=> amountInput = val,
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted:(_) => _submitData(),// onSubmitted expects a value, but our function is void, so we just put anything like val,_ to play around it, since we won't use it;
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                  Expanded(child: Text('${_selectedDate == null ? 'No Date Chosen': DateFormat.yMd().format(_selectedDate)}')),
                  AdaptiveFlatButton('Choose Date', _presentDatePicker),
                ],),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,

                onPressed: _submitData,
                // onPressed:(){
                //   addTx(
                //     titleController.text,
                //     double.parse(amountController.text),
                //   );
                // },
                child: Text(
                  "Add Transaction",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textColor: Theme.of(context).textTheme.button.color,
              ),
            ],
          ),
        ),
      ),
    );


  }
}
