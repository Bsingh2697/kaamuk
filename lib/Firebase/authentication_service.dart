import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaamuk/Screens/InnerScreens/dashboard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Successfully Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signUp({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required String? gender,
    required String phone,
    required String dob,
    required var image,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      FirebaseDatabase database = FirebaseDatabase.instance;

      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      log(user!.uid);

      DatabaseReference ref =
          FirebaseDatabase.instance.ref("users/${user.uid}");

      await ref.set({
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "gender": gender,
        "dob": dob,
        "image": [image.path.split('/').last]
      });

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference sRef =
          storage.ref().child("${user.uid}/${image.path.split('/').last}");
      UploadTask uploadTask = sRef.putFile(image);
      return "Successfully Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
