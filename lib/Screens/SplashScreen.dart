import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kaamuk/Screens/OuterScreens/Login.dart';
import 'package:kaamuk/Utils/AppConstants.dart';
import 'package:kaamuk/Utils/WidgetFunctions.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:kaamuk/Utils/ThemeConstants.dart';
import 'package:kaamuk/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // log("SPLASH SCREEN INIT");
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: splashTime), () {});
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    Gradient gradient =
        LinearGradient(colors: [COLOR_THEME_GREEN, COLOR_THEME_PINK]);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Container(
                  child: Image.asset(
                'assets/images/Logo.png',
                height: 200,
                width: 200,
              )),
              Container(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GradientText(
                        "Made with ",
                        gradient: gradient,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 3,
                            fontFamily: 'LoversQuarrel'),
                      ),
                      Image.asset(
                        'assets/images/heart.png',
                        height: 20,
                        width: 20,
                      ),
                      GradientText(
                        " in UK",
                        gradient: gradient,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 3,
                            fontFamily: 'LoversQuarrel'),
                      )
                    ],
                  ),
                  addVerticalSpace(10)
                ],
              ))
            ]),
      )),
    );
  }
}
