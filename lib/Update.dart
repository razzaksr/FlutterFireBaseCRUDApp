import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Updation extends StatefulWidget {
  // const Updation({super.key});
  int accNum;
  Updation(this.accNum);

  @override
  State<Updation> createState() => _UpdationState();
}

class _UpdationState extends State<Updation> {
  var accNumberController=TextEditingController();
  var accHolderController=TextEditingController();
  var accBalanceController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating records of ${widget.accNum}'),
        centerTitle: true,
      ),
      // body:FutureBuilder(
      //     future: API.readOne(widget.accNum),
      //     builder: (BuildContext context,AsyncSnapshot snapshot){
      //     if(!snapshot.hasData){
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     else{
      //       Customers customers=snapshot.data;
      //       accNumberController.text=customers.accNumber.toString();
      //       accHolderController.text=customers.accHolder;
      //       accBalanceController.text=customers.accBalance.toString();
      //       return Center(
      //         child: Padding(
      //           padding: const EdgeInsets.all(15.0),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.stretch,
      //             children: [
      //               TextField(
      //                 controller: accNumberController,
      //                 decoration: InputDecoration(
      //                     hintText: "Account number here"
      //                 ),
      //               ),
      //               TextField(
      //                 controller: accHolderController,
      //                 decoration: InputDecoration(
      //                     hintText: "Account holder here"
      //                 ),
      //               ),
      //               TextField(
      //                 controller: accBalanceController,
      //                 decoration: InputDecoration(
      //                     hintText: "Account balance here"
      //                 ),
      //               ),
      //               SizedBox(height: 15.0,),
      //               Center(
      //                 child: ElevatedButton.icon(
      //                   onPressed: (){
      //                     Customers customers=Customers.named(int.parse(accNumberController.text),
      //                         accHolderController.text, double.parse(accBalanceController.text));
      //                     var msg=API.updateOne(customers);
      //                     Toast.show("${msg}",duration:Toast.lengthLong);
      //                     // Navigator.pop(context);
      //                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Read()));
      //                   },
      //                   icon: Icon(Icons.upload),
      //                   label: Text("Update Account"),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //       );
      //     }
      // })
    );
  }
}
