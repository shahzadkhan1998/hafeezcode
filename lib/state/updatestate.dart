import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userscreen/repo/updateuser.dart';

class ProfileUpdaterState {
  final bool isLoading;

  ProfileUpdaterState({required this.isLoading});
}

class ProfileUpdater extends StateNotifier<ProfileUpdaterState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  updateuser _updateUset= updateuser();

  ProfileUpdater() : super(ProfileUpdaterState(isLoading: false));

  Future<void> updateData(String firstName, String lastName, String gender) async {
    try {
      state = ProfileUpdaterState(isLoading: true);
     
        _updateUset.udateData(firstName, lastName, gender);
  
      state = ProfileUpdaterState(isLoading: false);
    } catch (error) {
      print("Error updating data: $error");
      state = ProfileUpdaterState(isLoading: false);
    }
  }
}
