
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/models/CustomUser.dart';
import 'package:flutter_firebase_auth/services/auth.dart';
import 'package:flutter_firebase_auth/shared/constants.dart';
import 'package:flutter_firebase_auth/shared/loading.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading=false;

  // text field state
  String email = '';
  String password = '';
  String name='';
  String country='';
  String error = '';

  TextEditingController _userCountryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        elevation: 0.0,
        title: Text('Sign Up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'password'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Name'),
                validator: (val) => val.isEmpty ? 'Enter valid Name' : null,
                onChanged: (val) {
                  setState(() => name = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _userCountryController,
                decoration: textInputDecoration.copyWith(hintText: 'Country'),
                validator: (val) => val.isEmpty  ? 'Enter Valid Country' : null,
                onChanged: (val) {
                  setState(() => country = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.orange[900],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      CustomUserFields customUserFields =CustomUserFields(name,country);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password,customUserFields);
                      if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email';
                        });
                      }
                    }

                   // customUserFields.country =_userCountryController.text;
                    //final uid = Provider.of(context).auth.getCurrentUID();
                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
