import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:kaamuk/Screens/InnerScreens/dashboard.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class StorageService {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> downloadUrlImage(String uid) async {
    log("Download Called for URL :" + uid);
    String downloadURL = await storage
        .ref("${uid}/image_picker8911793105319809557.jpg")
        .getDownloadURL();
    log(downloadURL);
    return downloadURL;
  }
}

class UserData {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? userData;
  late DatabaseReference curUserRef;
  UserData() {
    userData = auth.currentUser;
    curUserRef = FirebaseDatabase.instance.ref("users/${userData!.uid}");
  }

  Future<String?> currentUserId() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = await auth.currentUser!;
    final uid = user.uid;
    log("User ID" + uid);
    return uid;
  }

  Future<String?> userImage(String? uId) async {
    log("User ID Image k liye" + uId!);
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$uId').get();
    String? downloadURL = 'Test';
    if (snapshot.exists) {
      if (kDebugMode) {
        print(snapshot
            .child('image')
            .value
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', ''));
      }
      var img = snapshot
          .child('image')
          .value
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '');
      downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('${uId}/${img}')
          .getDownloadURL();
      log("Sab set ho gya" + downloadURL);
    } else {
      if (kDebugMode) {
        print('No data available.');
      }
    }
    return downloadURL;
  }

  Future<String?> userName(String? uId) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('users/$uId').get();

    var name = '';
    if (snapshot.exists) {
      name = snapshot
              .child('firstname')
              .value
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '') +
          snapshot
              .child('lastname')
              .value
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '');
    } else {
      if (kDebugMode) {
        print('No data available.');
      }
    }

    return name;
  }
}


// class UserInfo {
//   late final String image;
//   late final String firstname;
//   late final String lastname;
//   late final String gender;
//   late final String phone;
//   late final String dob;

//   UserInfo({
//     required this.firstname,
//     required this.lastname,
//     required this.gender,
//     required this.phone,
//     required this.dob,
//     required this.image,
//   });

//   factory UserInfo.fromJson(Map<String, dynamic> json) {
//     return UserInfo(
//         firstname: json['firstname'],
//         lastname: json['lastname'],
//         gender: json['gender'],
//         phone: json['phone'],
//         dob: json['dob'],
//         image: json['image']);
//   }
// }
