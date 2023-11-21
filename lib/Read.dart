
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_base_one/Create.dart';
import 'package:toast/toast.dart';
import 'Update.dart';

class Read extends StatefulWidget {
  const Read({super.key});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('CRUD App'),
          centerTitle: true,
          backgroundColor: Colors.lightBlue,
        ),
        body:StreamBuilder(
          stream: _firestore.collection("kyc").snapshots(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else{
              List<DocumentSnapshot> myAll=snapshot.data.docs;
              return ListView.builder(
                shrinkWrap:true,
                itemCount: myAll.length,
                itemBuilder: (BuildContext context,int index){
                  // return ListTile(
                  //   leading:Icon(Icons.person),
                  //   title: Text(myAll[index].accHolder),
                  // );
                  return Card(
                    margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
                    child: ListTile(
                      onTap: (){
                        // Fluttertoast.showToast(msg: "hai");
                        Toast.show("Account Number "+myAll[index]['account'].toString()+" Balance is "+myAll[index]['balance'].toString(),duration: Toast.lengthLong);
                      },
                      leading: Icon(Icons.person),
                      title: Text(myAll[index]['holder']),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(child: Text('Edit'),onTap: (){
                            Toast.show("Edit Clicked");
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Updation(myAll[index].id)));
                          },),
                          PopupMenuItem(child: Text('Delete'),onTap: (){
                            Toast.show("Delete Clicked");
                            //API.deleteOne(myAll[index].accNumber);
                            //Navigator.pop(context,true);
                          },),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Creation()));
          },
          child: Icon(Icons.add),
        ),
    );
  }
}