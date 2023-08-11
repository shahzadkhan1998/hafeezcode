import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class updateuser
{

  Future<void> udateData(firstname,lastname,gender) async 
  {
final FirebaseAuth auth = FirebaseAuth.instance;
  User? user =  auth.currentUser;
    final CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.doc(user!.uid).update({
    'firstName': firstname,
    'lastName': lastname,
    'gender': gender,
  }).then((value) {

      debugPrint("Data Updated Successfully");
  
  });
  }
 
}