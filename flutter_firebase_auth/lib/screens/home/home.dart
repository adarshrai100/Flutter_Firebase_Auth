import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/services/auth.dart';

class Home extends StatelessWidget {

   final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
