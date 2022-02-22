import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaamuk/Firebase/authentication_service.dart';
import 'package:kaamuk/Firebase/storage_service.dart';
import 'package:kaamuk/Utils/WidgetFunctions.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:kaamuk/Firebase/storage_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // @override
  // void initState() {
  //   super.initState();
  //   log("Dashboard Init");
  //   _getUserData().then((value) => log("User Data THen"));
  // }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final StorageService storage = StorageService();
  final UserData uData = UserData();
  User? userData;
  late String uid;
  late DatabaseReference curUserRef;
  _DashboardState() {
    userData = auth.currentUser;
    uid = userData!.uid;
    curUserRef = FirebaseDatabase.instance.ref("users/${userData!.uid}");
  }

  // _getUserData() async {
  //   log("User Data");
  //   DatabaseEvent event = await curUserRef.once();
  //   log("User Data Fetch");
  //   if (kDebugMode) {
  //     print(event.snapshot.value);
  //   }
  //   log("User Data Finish");
  // }

  @override
  Widget build(BuildContext context) {
    // final User? user = auth.currentUser;
    // final uid = user!.uid;

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [screenHeader()],
          ),
        ),
      ),
    );
  }
}

// children: [
//             Text("HOME"),
//             ElevatedButton(
//               onPressed: () {
//                 context.read<AuthenticationService>().signOut();
//               },
//               child: Text("Sign out"),
//             ),
//             FutureBuilder(
//               future: storage.downloadUrlImage('ByyXdTk9b0WHTF6G7CMQngNtFjT2'),
//               builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done &&
//                     snapshot.hasData) {
//                   return Container(
//                       width: 300,
//                       height: 300,
//                       child: Image.network(snapshot.data!, fit: BoxFit.cover));
//                 }
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 }
//                 return Container();
//               },
//             )
//           ],
