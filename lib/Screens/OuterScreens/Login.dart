import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaamuk/Screens/OuterScreens/Registration.dart';
import 'package:kaamuk/Utils/WidgetFunctions.dart';
import 'package:kaamuk/Utils/ThemeConstants.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:kaamuk/Firebase/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Gradient gradient =
      LinearGradient(colors: [COLOR_THEME_GREEN, COLOR_THEME_PINK]);
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    handleSubmit() {
      context.read<AuthenticationService>().signIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    }

    return Scaffold(
        body: SafeArea(
      child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/backgrd.png"),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(60, 20, 60, 30),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addVerticalSpace(20),
                Container(
                  child: GradientText(
                    "Kaamuk",
                    gradient: gradient,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 50,
                        letterSpacing: 4,
                        fontFamily: 'LoversQuarrel'),
                  ),
                ),
                Form(
                    key: _loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Username",
                              style: themeData.textTheme.subtitle1,
                            )),
                        addVerticalSpace(5),
                        TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                            style: TextStyle(
                              color: COLOR_WHITE,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            decoration: InputDecoration(
                              fillColor: COLOR_THEME_GREEN,
                              filled: true,
                              hintText: "Email",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: COLOR_THEME_GREEN, width: 0.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: COLOR_THEME_GREEN, width: 0.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintStyle: TextStyle(color: COLOR_WHITE),
                              isDense: true,
                            )),
                        addVerticalSpace(20),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Password",
                              style: themeData.textTheme.subtitle1,
                            )),
                        addVerticalSpace(5),
                        TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            style: TextStyle(
                              color: COLOR_WHITE,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                            decoration: InputDecoration(
                                fillColor: COLOR_THEME_GREEN,
                                filled: true,
                                isDense: true,
                                hintText: "Password",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: COLOR_THEME_GREEN, width: 0.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: COLOR_THEME_GREEN, width: 0.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                hintStyle: TextStyle(color: COLOR_WHITE))),
                        addVerticalSpace(10),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: COLOR_BLACK,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_loginFormKey.currentState!.validate()) {
                                  List<String> providers = await FirebaseAuth
                                      .instance
                                      .fetchSignInMethodsForEmail(
                                          emailController.text);
                                  if (providers != null &&
                                      providers.length > 0) {
                                    handleSubmit();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "No User Found!");
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 30),
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  textStyle: themeData.textTheme.subtitle1,
                                  primary: COLOR_THEME_BLACK,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: Text("Login")),
                        )
                      ],
                    )),
                SizedBox(),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "New User?",
                        style: themeData.textTheme.subtitle2,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Registration()));
                        },
                        child: Text(
                          " Sign Up",
                          style: TextStyle(
                            color: COLOR_THEME_GREEN,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
          )),
    ));
  }
}
