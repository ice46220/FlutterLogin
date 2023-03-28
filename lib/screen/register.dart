import 'package:flutter/cupertino.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../model/profile.dart';
import 'home.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '',firstName: '',lastName: '');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints.expand(), //ขยายให้เต็ม widget
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent, //สีพื้นหลังโปร่งใส
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 49,
              ),
              Stack(children: [
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "SIGN UP",
                      style: GoogleFonts.outfit(
                        color: HexColor("#473B1E"),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(19, 0, 0, 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeScreen();
                      }));
                    },
                    child: Image(
                      alignment: Alignment.topLeft,
                      width: 33,
                      height: 33,
                      image: Svg('assets/images/pic5arrowleft.svg'),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 19,
              ),
              Text(
                "Please enter the information \nbelow to access.",
                style: GoogleFonts.outfit(
                  color: HexColor("#473B1E"),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Image(
                width: 86,
                height: 88,
                image: Svg('assets/images/pic4up.svg'),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(45, 0, 45, 0),
                  child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(children: [
                              Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    new BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        //box-shadow: rgba(0, 0, 0, 0.12) 0px 2px 1px
                                        color: Color.fromRGBO(0, 0, 0, 0.12),
                                        offset: Offset(0, 2),
                                        blurRadius: 1,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  )),
                              TextFormField(
                                maxLines: 1,
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนชื่อ"),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: HexColor("#F3F3F3"),
                                  hintText: 'First name',
                                  hintStyle: GoogleFonts.outfit(
                                    color: HexColor("#666161"),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  focusedBorder: _makeRoundedInputBorder(),
                                  enabledBorder: _makeRoundedInputBorder(),
                                  errorBorder: _makeRoundedInputBorder(),
                                  focusedErrorBorder: _makeRoundedInputBorder(),
                                ),
                                obscureText: true,
                                onSaved: (String? firstName) {
                                  profile.firstName = firstName!;
                                },
                              ),
                            ]),
                            SizedBox(
                              height: 15,
                            ),
                            Stack(children: [
                              Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    new BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        //box-shadow: rgba(0, 0, 0, 0.12) 0px 2px 1px
                                        color: Color.fromRGBO(0, 0, 0, 0.12),
                                        offset: Offset(0, 2),
                                        blurRadius: 1,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  )),
                              TextFormField(
                                maxLines: 1,
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนนามสกุล"),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: HexColor("#F3F3F3"),
                                  hintText: 'Last name',
                                  hintStyle: GoogleFonts.outfit(
                                    color: HexColor("#666161"),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  focusedBorder: _makeRoundedInputBorder(),
                                  enabledBorder: _makeRoundedInputBorder(),
                                  errorBorder: _makeRoundedInputBorder(),
                                  focusedErrorBorder: _makeRoundedInputBorder(),
                                ),
                                obscureText: true,
                                onSaved: (String? lastName) {
                                  profile.lastName = lastName!;
                                },
                              ),
                            ]),
                            SizedBox(
                              height: 15,
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        //box-shadow: rgba(0, 0, 0, 0.12) 0px 2px 1px
                                        color: Color.fromRGBO(0, 0, 0, 0.12),
                                        offset: Offset(0, 2),
                                        blurRadius: 1,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  maxLines: 1,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText:
                                            "กรุณาป้อนอีเมล์"), //ดักค่าว่า
                                    EmailValidator(
                                        errorText: "รูปแบบอีเมล์ไม่ถูกต้อง")
                                  ]),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: HexColor("#F3F3F3"),
                                    hintText: 'Email',
                                    hintStyle: GoogleFonts.outfit(
                                      color: HexColor("#666161"),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    focusedBorder: _makeRoundedInputBorder(),
                                    enabledBorder: _makeRoundedInputBorder(),
                                    errorBorder: _makeRoundedInputBorder(),
                                    focusedErrorBorder:
                                        _makeRoundedInputBorder(),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (String? email) {
                                    profile.email = email!;
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Stack(children: [
                              Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                    boxShadow: [
                                      BoxShadow(
                                        //box-shadow: rgba(0, 0, 0, 0.12) 0px 2px 1px
                                        color: Color.fromRGBO(0, 0, 0, 0.12),
                                        offset: Offset(0, 2),
                                        blurRadius: 1,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  )),
                              TextFormField(
                                maxLines: 1,
                                validator: RequiredValidator(
                                    errorText: "กรุณาป้อนรหัสผ่าน"),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: HexColor("#F3F3F3"),
                                  hintText: 'Password',
                                  hintStyle: GoogleFonts.outfit(
                                    color: HexColor("#666161"),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  focusedBorder: _makeRoundedInputBorder(),
                                  enabledBorder: _makeRoundedInputBorder(),
                                  errorBorder: _makeRoundedInputBorder(),
                                  focusedErrorBorder: _makeRoundedInputBorder(),
                                ),
                                obscureText: true,
                                onSaved: (String? password) {
                                  profile.password = password!;
                                },
                              ),
                            ]),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [
                                      HexColor("#53CD9F"),
                                      HexColor("#0D7A5C"),
                                    ],
                                    begin: FractionalOffset.topCenter,
                                    end: FractionalOffset.bottomCenter,
                                    stops: [0.0, 1.0],
                                    //transform: GradientRotation(180 * 3.14 / 180), //กลับหัว
                                  ),
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState?.save();
                                        print(
                                            "email = ${profile.email} passsword = ${profile.password} first = ${profile.firstName} last = ${profile.lastName}");
                                        formKey.currentState
                                            ?.reset(); //เคลียร์ฟอร์มเป็นค่าว่าง
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text("Success Your account has been saved"),
                                          backgroundColor: Colors.green[300],
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5.00),
                                            ),
                                          ),
                                        ));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        backgroundColor: Colors.transparent),
                                    child: Text(
                                      "SIGN UP",
                                      style: GoogleFonts.outfit(
                                        color: HexColor("#FFFFFF"),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ))),
                          ],
                        ),
                      )),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _makeRoundedInputBorder() => //กำหนดขอบ
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(
          color: HexColor("#F3F3F3"),
        ),
      );
}
