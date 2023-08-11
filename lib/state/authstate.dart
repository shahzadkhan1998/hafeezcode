import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userscreen/login.dart';
import 'package:userscreen/profile.dart';
import 'package:userscreen/repo/user_auth.dart';

class AuthState {
  final User? user;

  AuthState(this.user);
}

class AuthNotifier extends StateNotifier<AuthState?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserAuth _userAuth = UserAuth();

  AuthNotifier() : super(null) {
    _auth.authStateChanges().listen((user) {
      state = AuthState(user);
    });
  }

  Future<void> signInWithGoogle(context) async {
    Future<UserCredential?> _user = _userAuth.signInWithGoogle();
    if(_user != null)
    {
      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { 
      //   return Profile();
        
      //  }));
    }
   
  }

  Future<void> signWithEmailPassword(email,password,context) async{
    UserCredential? userCredential = await _userAuth.signInWithEmailAndPassword(email,password);
    if(userCredential != null)
    {
     _userAuth. saveUserDataToFirestore(userCredential.user!,email,password);
    
    print("User Login is Successfull");
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { 
      return Profile();
     }));
  }
  
}

Future<void> registerWithEmailAndPassword(email,password,context) async{
 UserCredential?  userCredential = await _userAuth.registerWithEmailAndPassword(email, password);
 if(userCredential != null)
 {     
 _userAuth. saveUserDataToFirestore(userCredential.user!,email,password);

  print("User Register Successfull");
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { 
        return Login();
        
       }));
 }
}
}
