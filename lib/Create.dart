import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Creation extends StatefulWidget {
  const Creation({super.key});

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  var accNumberController=TextEditingController();
  var accHolderController=TextEditingController();
  var accBalanceController=TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an account'),
        centerTitle: true,
      ),
      body: Center(
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
                      await _firestore.collection("kyc").add(data);
                      Toast.show("KYC added",duration: Toast.lengthLong);
                    },
                    icon: Icon(Icons.add),
                    label: Text("Create new Account"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
