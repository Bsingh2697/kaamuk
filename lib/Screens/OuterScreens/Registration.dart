import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaamuk/Screens/InnerScreens/dashboard.dart';
import 'package:kaamuk/Screens/OuterScreens/Registration.dart';
import 'package:kaamuk/Utils/WidgetFunctions.dart';
import 'package:kaamuk/Utils/ThemeConstants.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:kaamuk/Firebase/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _registerFormKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  var userImage;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobMonthController = TextEditingController();
  final TextEditingController dobDayController = TextEditingController();
  final TextEditingController dobYearController = TextEditingController();

  String? gender;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    handleImagePick() async {
      log("Picker Called");
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        // userImage = File(image!.path);
        userImage = File(image!.path);
      });
    }

    handleSubmit() async {
      // log("DATA :");
      // log("email:" + emailController.text.trim());
      // log("password:" + passwordController.text.trim());
      // log("firstname:" + firstNameController.text.trim());
      // log("lastname:" + lastNameController.text.trim());
      // log("gender:" + gender!);
      // log("phone:" + phoneController.text.trim());
      // log("dob:" + dateofbirth.toString());
      // log("Image: ${userImage ?? ''}");

      final dateofbirth = DateTime.utc(
          int.parse(dobYearController.text.trim()),
          int.parse(dobMonthController.text.trim()),
          int.parse(dobDayController.text.trim()));

      await context.read<AuthenticationService>().signUp(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            firstname: firstNameController.text.trim(),
            lastname: lastNameController.text.trim(),
            gender: this.gender,
            phone: phoneController.text.trim(),
            dob: dateofbirth.toString(),
            image: userImage,
          );

      Navigator.pop(context);
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/backgrd.png"),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(60, 20, 60, 30),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      userImage != null
                          ? Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  color: COLOR_GREY,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.file(File(userImage!.path),
                                  width: 100, height: 100, fit: BoxFit.cover),
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: COLOR_LIGHT_GREY,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image(
                                image: AssetImage("assets/images/person.png"),
                                // height: 50,
                              )),
                      Container(),
                      ElevatedButton(
                        child: Text("Upload Image"),
                        onPressed: () {
                          handleImagePick();
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 30),
                            padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                            textStyle: themeData.textTheme.subtitle1,
                            primary: COLOR_THEME_BLACK,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                      addVerticalSpace(45),
                      Form(
                          key: _registerFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // First Name
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        "First name ",
                                        style: themeData.textTheme.subtitle1,
                                      ),
                                      Image(
                                        image: AssetImage(
                                            "assets/images/starReq.png"),
                                        height: 7,
                                      )
                                    ],
                                  )),
                              addVerticalSpace(5),
                              TextFormField(
                                  controller: firstNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter first name';
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
                                    hintText: "First name",
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: COLOR_THEME_GREEN,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: COLOR_THEME_GREEN,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    hintStyle: TextStyle(color: COLOR_WHITE),
                                    isDense: true,
                                  )),
                              // Last Name
                              addVerticalSpace(20),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Last name ",
                                        style: themeData.textTheme.subtitle1,
                                      ),
                                      Image(
                                        image: AssetImage(
                                            "assets/images/starReq.png"),
                                        height: 7,
                                      )
                                    ],
                                  )),
                              addVerticalSpace(5),
                              TextFormField(
                                  controller: lastNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter last name';
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
                                    hintText: "Last name",
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: COLOR_THEME_GREEN,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: COLOR_THEME_GREEN,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    hintStyle: TextStyle(color: COLOR_WHITE),
                                    isDense: true,
                                  )),

                              // Date of birth
                              addVerticalSpace(20),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Date of birth ",
                                        style: themeData.textTheme.subtitle1,
                                      ),
                                      Image(
                                        image: AssetImage(
                                            "assets/images/starReq.png"),
                                        height: 7,
                                      )
                                    ],
                                  )),
                              addVerticalSpace(5),
                              Row(
                                children: [
                                  Container(
                                    width: 25,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: dobMonthController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter dob month';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'MM',
                                          hintStyle: TextStyle(
                                              color: COLOR_PLACEHOLDER,
                                              fontWeight: FontWeight.w300),
                                          isDense: true,
                                          contentPadding: EdgeInsets.only(
                                              top: 0, bottom: 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text('/'),
                                  Container(
                                    width: 25,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: dobDayController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter dob day';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'DD',
                                          hintStyle: TextStyle(
                                              color: COLOR_PLACEHOLDER,
                                              fontWeight: FontWeight.w300),
                                          isDense: true,
                                          contentPadding: EdgeInsets.only(
                                              top: 0, bottom: 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text('/'),
                                  Container(
                                    width: 50,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: dobYearController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter dob year';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'YYYY',
                                          hintStyle: TextStyle(
                                              color: COLOR_PLACEHOLDER,
                                              fontWeight: FontWeight.w300),
                                          isDense: true,
                                          contentPadding: EdgeInsets.only(
                                              top: 0, bottom: 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              // Gender
                              addVerticalSpace(20),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Gender ",
                                        style: themeData.textTheme.subtitle1,
                                      ),
                                      Image(
                                        image: AssetImage(
                                            "assets/images/starReq.png"),
                                        height: 7,
                                      )
                                    ],
                                  )),
                              addVerticalSpace(5),
                              Container(
                                height: 35,
                                decoration: BoxDecoration(
                                    color: COLOR_THEME_GREEN,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: DropdownButton(
                                    value: gender,
                                    isExpanded: true,
                                    dropdownColor: COLOR_THEME_BLACK,
                                    hint: Text(
                                      '-select-',
                                      style: TextStyle(color: COLOR_WHITE),
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        gender = newValue!;
                                      });
                                    },
                                    items: ['Male', 'Female', 'Others']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value, child: Text(value));
                                    }).toList(),
                                    style: TextStyle(
                                      color: COLOR_WHITE,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                    iconEnabledColor: COLOR_WHITE,
                                  ),
                                ),
                              ),

                              // Phone Number
                              addVerticalSpace(20),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Phone Number ",
                                        style: themeData.textTheme.subtitle1,
                                      ),
                                      Image(
                                        image: AssetImage(
                                            "assets/images/starReq.png"),
                                        height: 7,
                                      )
                                    ],
                                  )),
                              addVerticalSpace(5),
                              TextFormField(
                                  controller: phoneController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter phone umber';
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
                                    hintText: "Phone number",
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: COLOR_THEME_GREEN,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: COLOR_THEME_GREEN,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    hintStyle: TextStyle(color: COLOR_WHITE),
                                    isDense: true,
                                  )),

                              // Email
                              addVerticalSpace(20),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Email ",
                                        style: themeData.textTheme.subtitle1,
                                      ),
                                      Image(
                                        image: AssetImage(
                                            "assets/images/starReq.png"),
                                        height: 7,
                                      )
                                    ],
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
                                            color: COLOR_THEME_GREEN,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: COLOR_THEME_GREEN,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    hintStyle: TextStyle(color: COLOR_WHITE),
                                    isDense: true,
                                  )),

                              // Password
                              addVerticalSpace(20),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Password ",
                                        style: themeData.textTheme.subtitle1,
                                      ),
                                      Image(
                                        image: AssetImage(
                                            "assets/images/starReq.png"),
                                        height: 7,
                                      )
                                    ],
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
                                    hintText: "Password",
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: COLOR_THEME_GREEN,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: COLOR_THEME_GREEN,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    hintStyle: TextStyle(color: COLOR_WHITE),
                                    isDense: true,
                                  )),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      // if (_registerFormKey.currentState!
                                      //     .validate()) {
                                      // List<String> providers =
                                      //     await FirebaseAuth.instance
                                      //         .fetchSignInMethodsForEmail(
                                      //             emailController.text);
                                      // if (providers.isNotEmpty) {
                                      //   Fluttertoast.showToast(
                                      //       msg: "User Already Exists!");
                                      // } else {
                                      handleSubmit();
                                      // }
                                      // }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: Size(double.infinity, 30),
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        textStyle:
                                            themeData.textTheme.subtitle1,
                                        primary: COLOR_THEME_BLACK,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    child: Text("Sign Up")),
                              )
                            ],
                          ))
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
