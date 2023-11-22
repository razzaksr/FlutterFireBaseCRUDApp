import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_base_one/Read.dart';
import 'package:my_base_one/Signup.dart';
import 'package:toast/toast.dart';
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var mailController=TextEditingController();
  var passController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn'),
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
                      await FirebaseAuth.instance.signInWithEmailAndPassword(email: mailController.text, password: passController.text);
                      Toast.show("SignIn success",duration: Toast.lengthLong);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Read(),));
                    },
                    icon: Icon(Icons.login_outlined),
                    label: Text('SignIn')
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.app_registration),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
        },
      ),
    );
  }
}
