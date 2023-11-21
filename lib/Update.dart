import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_base_one/Read.dart';
import 'package:toast/toast.dart';

class Updation extends StatefulWidget {
  // const Updation({super.key});
  String docId;
  Updation(this.docId);

  @override
  State<Updation> createState() => _UpdationState();
}

class _UpdationState extends State<Updation> {
  var accNumberController=TextEditingController();
  var accHolderController=TextEditingController();
  var accBalanceController=TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  readOneFromFirebase()async{
    DocumentSnapshot snapshot = await _firestore.collection("kyc").doc(widget.docId).get();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Updating records of ${widget.docId}'),
        centerTitle: true,
      ),
      body:StreamBuilder(
          stream: _firestore.collection("kyc").doc(widget.docId).get().asStream(), //readOneFromFirebase() as Stream<dynamic>,
          builder: (BuildContext context,AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else{
            DocumentSnapshot snap = snapshot.data;
            print(snap);
            accNumberController.text=snap['account'].toString();
            accHolderController.text=snap['holder'];
            accBalanceController.text=snap['balance'].toString();
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: accNumberController,
                      decoration: InputDecoration(
                          hintText: "Account number here"
                      ),
                    ),
                    TextField(
                      controller: accHolderController,
                      decoration: InputDecoration(
                          hintText: "Account holder here"
                      ),
                    ),
                    TextField(
                      controller: accBalanceController,
                      decoration: InputDecoration(
                          hintText: "Account balance here"
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: ()async{
                          Map<String,dynamic> data={
                            "holder":accHolderController.text,
                            "account":num.parse(accNumberController.text),
                            "balance":num.parse(accBalanceController.text)
                          };
                          await _firestore.collection("kyc").doc(widget.docId).update(data);
                          Toast.show("KYC updated",duration: Toast.lengthLong);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Read(),));
                        },
                        icon: Icon(Icons.upload),
                        label: Text("Update Account"),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      })
    );
  }
}
