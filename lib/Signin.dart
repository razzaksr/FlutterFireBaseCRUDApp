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

  final mobileController=TextEditingController();
  final otpController=TextEditingController();

  String verificationId="";

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('SignIn'),
          centerTitle: true,
          bottom: TabBar(
            indicator: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(50.0)
            ),
            tabs: [
              Tab(icon:Icon(Icons.email_outlined)),
              Tab(icon:Icon(Icons.phone_android_outlined))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
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
                          label: Text('Signin')
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                child: Form(
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.phone,
                        controller: mobileController,
                        decoration: InputDecoration(hintText: 'Mobile Number'),
                      ),
                      SizedBox(height: 20.0,),
                      OutlinedButton.icon(
                          onPressed: ()async{
                            await FirebaseAuth.instance.verifyPhoneNumber(
                                phoneNumber: mobileController.text,
                                verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async{
                                  await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
                                },
                                verificationFailed: (FirebaseAuthException e){
                                  Toast.show("Error phone number verify $e",duration: Toast.lengthLong);
                                  },
                                codeSent: (String verificationId, int? forceResendingToken) {
                                  setState(() {
                                    this.verificationId=verificationId;
                                  });
                                  Toast.show("Verification code has sent to mobile",duration: Toast.lengthLong);
                                },
                                codeAutoRetrievalTimeout: (String verificationId) {
                                  setState(() {
                                    this.verificationId=verificationId;
                                  });
                                },
                            );
                          },
                          icon: Icon(Icons.verified_outlined),
                          label: Text('')
                      ),
                      TextFormField(
                        controller: otpController,
                        decoration: InputDecoration(hintText: 'OTP'),
                      ),
                      OutlinedButton.icon(
                          onPressed: ()async{
                            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: otpController.text,
                            );
                            await FirebaseAuth.instance.signInWithCredential(credential);
                            Toast.show("SignIn success",duration: Toast.lengthLong);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Read(),));
                          },
                          icon: Icon(Icons.login_outlined),
                          label: Text('Signin')
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.app_registration),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
          },
        ),
      ),
    );
  }
}
