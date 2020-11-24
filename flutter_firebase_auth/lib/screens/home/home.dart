import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/models/CustomUser.dart';
import 'package:flutter_firebase_auth/services/auth.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   final AuthService _auth = AuthService();
    CustomUserFields customUserFields =CustomUserFields('', '');


   @override
  Widget build(BuildContext context) {
     final user = Provider.of<CustomUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          FlatButton.icon(onPressed: () async {
            await _auth.signOut();
          },
              icon: Icon(Icons.person),
              label: Text('Log Out', style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            /*FutureBuilder(
              future: Provider.of(context,listen: false).auth.getCurrentUID(),
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.done){
                  return Text("${snapshot.data}");
                }else{
                  return CircularProgressIndicator();
                }
              },
            )*/
            Text("${user.uid}"),
          ],
        )
      ),
    );
  }
}
