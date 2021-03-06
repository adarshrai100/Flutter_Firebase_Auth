import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/models/CustomUser.dart';
import 'package:flutter_firebase_auth/screens/authenticate/authenticate.dart';
import 'package:flutter_firebase_auth/screens/authenticate/sign_in.dart';
import 'package:flutter_firebase_auth/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser>(context);
    print(user);

    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
