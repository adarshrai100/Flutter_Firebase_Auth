import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/models/CustomUser.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db =FirebaseFirestore.instance;

  //create user obj based on FirebaseUser
  CustomUser _userFromFirebaseUser(User user){
    return user !=null ? CustomUser(uid: user.uid) : null;
  }

  Future<String> getCurrentUID() async{
    User user =  _auth.currentUser;

    return user.uid;
  }

  //auth change user stream
  Stream<CustomUser> get user{
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
        //.map((User user) => _userFromFirebaseUser(user));

  }
  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password,CustomUserFields customUserFields) async{
    try{
       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       User user = result.user;
    //   db.collection('userData').doc(user.uid).set(customUserFields.toJson());
       addCustomFields(customUserFields.name, customUserFields.country, user.uid,customUserFields);
       return _userFromFirebaseUser(user);
    }catch(e){
    print(e.toString());
    return null;
    }
  }

  void addCustomFields(String name,String country,String uid,CustomUserFields customUserFields) async{
    try{
      db.collection('userData').doc(uid).set(customUserFields.toJson());

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
    return await _auth.signOut();
    }catch(e){
    print(e.toString());
    return null;
    }
  }

}