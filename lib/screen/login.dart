import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../model/profile.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("เข้าสู่ระบบ")),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "อีเมล",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: "กรุณาป้อนอีเมล์"), //ดักค่าว่า
                        EmailValidator(errorText: "รูปแบบอีเมล์ไม่ถูกต้อง")
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String? email) {
                        profile.email = email!;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "รหัสผ่าน",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      validator:
                          RequiredValidator(errorText: "กรุณาป้อนรหัสผ่าน"),
                      obscureText: true,
                      onSaved: (String? password) {
                        profile.password = password!;
                      },
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState?.save();
                                print(
                                    "email = ${profile.email} passsword = ${profile.password}");
                                formKey.currentState
                                    ?.reset(); //เคลียร์ฟอร์มเป็นค่าว่าง
                              }
                            },
                            child: Text(
                              "ลงชื่อเข้าใช้",
                              style: TextStyle(fontSize: 20),
                            )))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}