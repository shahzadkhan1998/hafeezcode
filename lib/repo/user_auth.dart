import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth 
{
final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;



  Future<UserCredential?> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Save additional user data to Firestore.
      await saveUserDataToFirestore(userCredential.user!);

      return userCredential;
    }
  } catch (error) {
    print("Google sign-in error: $error");
    return null;
  }
}

 // sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // handle auth exceptions
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // register with email and password
  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // handle auth exceptions
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }


Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await _auth.signOut();
    } catch (error) {
      print("Sign-out error: $error");
    }
  }

 Future<void> saveUserDataToFirestore(User user,[email,password]) async {
  // Reference to the Firestore collection
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Create a document for the user using their UID // taking dummy name
  await users.doc(user.uid).set({
    'uid': user.uid,
    'email': user.email,
    'firstName': 'shah', 
    'lastName': 'khan',  
    'gender': 'Male',   
  });
}

}