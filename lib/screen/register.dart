import 'dart:developer';
import 'package:flutter_application_1/controller/base_api.dart';
import 'package:flutter_application_1/screen/widget/widget.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> createUserAPI() async {
    dynamic isSuccess = await CAllAPI()
        .createUser(fname.text, lname.text, email.text, password.text);
    log("isSuccess $isSuccess");
    if (isSuccess == "OK") {
      log("isSuccess$isSuccess");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Success Your account has been saved"),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green[300],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.00),
          ),
        ),
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isSuccess),
        backgroundColor: Colors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.00),
          ),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints.expand(), //ขยายให้เต็ม widget
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.transparent, //สีพื้นหลังโปร่งใส
            body: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
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
                        // Navigator.pushReplacement(context, //User สามารถกลับไปยังหน้าแรกด้วยตัวะเองได้ เช่นแบบiosที่ปัดหน้าจอกลับ
                        //     MaterialPageRoute(builder: (context) {
                        //   return const HomeScreen();
                        // }));
                        Navigator.pop(context);
                      },
                      child: const Image(
                        alignment: Alignment.topLeft,
                        width: 33,
                        height: 33,
                        image: Svg('assets/images/pic5arrowleft.svg'),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
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
                const SizedBox(
                  height: 40,
                ),
                const Image(
                  width: 86,
                  height: 88,
                  image: Svg('assets/images/pic4up.svg'),
                ),
                const SizedBox(
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
                              TextFieldWidget(
                                text:'First name' ,
                                controller:fname ,
                                validator: RequiredValidator(
                                    errorText: "Please enter your name"),
                                obscure: false,
                                onSaved:  (String? firstName) {
                                  fname.text = firstName!;
                                },
                                textType: TextInputType.name,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFieldWidget(
                                text:'Last name' ,
                                controller: lname ,
                                validator: RequiredValidator(
                                    errorText: "Please enter last name"),
                                obscure: false,
                                onSaved:  (String? lastName) {
                                  lname.text = lastName!;
                                },
                                textType: TextInputType.name,
                              ),

                              const SizedBox(
                                height: 15,
                              ),
                              TextFieldWidget(
                                text:'Email' ,
                                controller:email ,
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText:
                                      "Please enter your email"), //ดักค่าว่า
                                  EmailValidator(
                                      errorText: "Invalid email")
                                ]),
                                obscure: false,
                                onSaved:  (String? mail) {
                                  email.text = mail!;
                                },
                                textType: TextInputType.emailAddress,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              TextFieldWidget(
                                text:'Password' ,
                                controller: password ,
                                validator: RequiredValidator(
                                    errorText: "Please enter your password"),
                                obscure: true,
                                onSaved:  (String? pass) {
                                  password.text = pass!;
                                },
                                textType: TextInputType.text,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ButtonWidget(
                                textButton: "SIGN UP",
                                press: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState?.save();
                                    print(
                                        "data :${fname.text} ${lname.text} ${email.text} ${password.text}");
                                    createUserAPI();
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
