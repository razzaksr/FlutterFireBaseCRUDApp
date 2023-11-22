import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var mailController=TextEditingController();
  var passController=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup New User'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: mailController,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                OutlinedButton.icon(
                    onPressed: ()async{
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: mailController.text, password: passController.text);
                      Toast.show("Signup success",duration: Toast.lengthLong);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.app_registration),
                    label: Text('Signup')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
