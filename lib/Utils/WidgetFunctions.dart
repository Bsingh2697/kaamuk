import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:kaamuk/Firebase/storage_service.dart';
import 'package:kaamuk/Utils/ThemeConstants.dart';

Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(width: width);
}

Widget screenHeader() {
  final UserData uData = UserData();
  // TEST
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // String _userId, _phone;
  // Future<String> getCurrentUser() async {
  //   final User user = await auth.currentUser!;
  //   final uid = user.uid;
  //   return uid;
  // }

// Test
  return Container(
    decoration: BoxDecoration(color: COLOR_BLACK),
    padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: FutureBuilder(
              future: uData.currentUserId(),
              builder:
                  (BuildContext context, AsyncSnapshot<String?> snapshotCur) {
                if (snapshotCur.connectionState == ConnectionState.done &&
                    snapshotCur.hasData) {
                  if (kDebugMode) {
                    print(snapshotCur.data);
                  }
                  final ThemeData themeData = Theme.of(context);

                  log("USER ID RECEIVED : " + snapshotCur.data.toString());
                  return Row(
                    children: [
                      FutureBuilder(
                        future: uData.userImage(snapshotCur.data),
                        builder: (BuildContext context,
                            AsyncSnapshot<String?> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            if (kDebugMode) {
                              log("Final IMAGE URL");
                              print(snapshot.data);
                            }
                            return Container(
                              clipBehavior: Clip.hardEdge,
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: COLOR_LIGHT_GREY,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Image.network(
                                snapshot.data.toString(),
                                height: 100,
                                width: 100,
                              ),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          }
                          return Container();
                        },
                      ),
                      FutureBuilder(
                        future: uData.userName(snapshotCur.data),
                        builder: (BuildContext context,
                            AsyncSnapshot<String?> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            if (kDebugMode) {
                              log("Final IMAGE URL");
                              print(snapshot.data);
                            }
                            return Container(
                              child: Flexible(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Text(
                                    "saaaaaaaaaaasssssssssssssssssssssssssssssssssaaa${snapshot.data.toString()}",
                                    style: TextStyle(
                                        color: COLOR_WHITE,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        fontFamily: 'Roboto'),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          }
                          return Container();
                        },
                      )
                    ],
                  );
                }
                if (snapshotCur.connectionState == ConnectionState.waiting) {
                  return Container();
                }
                return Container();
              }),
        ),
        Flexible(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                decoration: BoxDecoration(color: COLOR_GREY),
                child: InkWell(
                    onTap: () {},
                    child: Image.asset('assets/images/textsms.png')),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                decoration: BoxDecoration(color: COLOR_GREY),
                child: InkWell(
                    onTap: () {},
                    child: Image.asset('assets/images/notifications.png')),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                decoration: BoxDecoration(color: COLOR_GREY),
                child: InkWell(
                    onTap: () {},
                    child: Image.asset('assets/images/settings.png')),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                decoration: BoxDecoration(color: COLOR_GREY),
                child: InkWell(
                    onTap: () {}, child: Image.asset('assets/images/exit.png')),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
