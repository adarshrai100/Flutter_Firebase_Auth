import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/animations/FadeAnimation.dart';
import 'package:flutter_firebase_auth/services/auth.dart';
import 'package:flutter_firebase_auth/shared/loading.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange[900],
                  Colors.orange[800],
                  Colors.orange[400]
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(1,Text("Login", style: TextStyle(color: Colors.white, fontSize: 40,),)),
                    SizedBox(height: 10,),
                    FadeAnimation(1.3,Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18,),))
                  ]
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40,),
                      FadeAnimation(1.5,Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, .3),
                                blurRadius: 20,
                                offset: Offset(0,10)
                            )]
                        ),
                        child: Form(
                            key: _formkey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: TextFormField(
                                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                                decoration: InputDecoration(
                                    hintText: 'Email or Phone Number',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                                onChanged: (val){
                                setState(() {
                                  email=val;
                                });
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: TextFormField(
                                validator: (val) => val.length < 6 ? 'Enter a password with more than 6 chars' : null,
                                decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                ),
                                obscureText: true,
                                onChanged: (val){
                                  setState(() {
                                    password=val;
                                  });
                                },
                              ),
                            ),
                          ],
                        )),
                      )),
                      SizedBox(height: 20,),
                      FadeAnimation(1.5,Text('Forgot Password?', style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 20,),
                      FadeAnimation(1.6,Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.orange[900],
                        ),
                        child: Center(
                          child: SizedBox(
                            height:50 ,
                            width: double.infinity,
                            child:FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            color: Colors.orange[900],
                            child: Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            onPressed: () async{
                              if(_formkey.currentState.validate()){
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                if(result==null){
                                  setState(() {
                                    loading = false;
                                    error='Could not Sign in with those credentials';
                                  });
                                }
                              }
                            },
                          )),
                        ),
                      )),
                      SizedBox(height: 50,),
                      FadeAnimation(1.7,Text('Continue with Social Media', style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 30,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FadeAnimation(1.8,Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue
                              ),
                              child: Center(
                                child: SizedBox(
                                    height:50 ,
                                    width: double.infinity,
                                    child:FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      color: Colors.blue,
                                      child: Text('Register', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                      onPressed: () async{
                                        widget.toggleView();
                                      },
                                    )),

                              ),
                            )),
                          ),
                          SizedBox(width: 30,),
                          Expanded(
                            child: FadeAnimation(1.9, Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black
                              ),
                              child: Center(
                                child: RaisedButton(
                                  color: Colors.black,
                                  child: Text('Anonymous', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  onPressed: () async{
                                    dynamic result = await _auth.signInAnon();
                                    if(result==null){
                                      print('error signing in');
                                    }else{
                                      print('signed in');
                                      print(result.uid);
                                    }
                                  },
                                ),
                                //child: Text('Anon', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red,fontSize: 14),
                        ),

                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
