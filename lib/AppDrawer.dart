import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_base_one/Create.dart';
import 'package:my_base_one/Read.dart';
import 'package:my_base_one/Signin.dart';
class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Icon(Icons.add_circle_outlined),
            title: Text('Create New'),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Creation(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.list_outlined),
            title: Text('View All'),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Read(),));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Logout'),
            onTap: ()async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),));
            },
          ),
          AboutListTile(
            icon: Icon(Icons.info_outline),
            child: Text('About my app'),
            applicationIcon: Icon(Icons.local_play),
            applicationName: 'My CRUD Security',
            applicationVersion: '1.4',
            applicationLegalese: 'C 2023 Company',
            aboutBoxChildren: [],
          )
        ],
      ),
    );
  }
}
