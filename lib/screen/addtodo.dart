import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final formKey = GlobalKey<FormState>();
  bool isSwitched = false;
  String message = '';
  String title = '';
  String dec = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //ปิดศรย้อน
        title: Row(
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      },
                      child: Image(
                        width: 40,
                        height: 40,
                        image: Svg('assets/images/vector.svg'),
                      ),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    Text("Add Your Todo",
                        style: GoogleFonts.outfit(
                          color: HexColor("##FFFFFF"),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                HexColor("#4CC599"),
                HexColor("#0D7A5C"),
              ],
              stops: [0.05, 1.84],
              transform: GradientRotation(172.65 * 3.14 / 180),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            //box-shadow: rgba(0, 0, 0, 0.2);0px 0px 6px
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            offset: Offset(0, 0),
                            blurRadius: 6,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          style: GoogleFonts.outfit(
                            color: Color.fromRGBO(102, 97, 97, 0.68),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Title",
                            hintStyle: GoogleFonts.outfit(
                              color: Color.fromRGBO(102, 97, 97, 0.68),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onSaved: (String? titleDec) {
                            title = titleDec!;
                          },
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            //box-shadow: rgba(0, 0, 0, 0.2);0px 0px 6px
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            offset: Offset(0, 0),
                            blurRadius: 6,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: TextFormField(
                          style: GoogleFonts.outfit(
                            color: Color.fromRGBO(102, 97, 97, 0.68),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 10,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Decription",
                            hintStyle: GoogleFonts.outfit(
                              color: Color.fromRGBO(102, 97, 97, 0.68),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onSaved: (String? decription) {
                            dec = decription!;
                          },
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            //box-shadow: rgba(0, 0, 0, 0.2);0px 0px 6px
                            color: Color.fromRGBO(0, 0, 0, 0.2),
                            offset: Offset(0, 0),
                            blurRadius: 6,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 20, 5),
                          child: ListTile(
                            leading: Text(
                              "Success",
                              style: GoogleFonts.outfit(
                                color: HexColor("#0D7A5C"),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: CupertinoSwitch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                  print(isSwitched);
                                });
                              },
                              thumbColor: Colors.white,
                              trackColor: HexColor("#3CB189"),
                              activeColor: Color.fromRGBO(0, 0, 0, 0.17),
                            ),
                          ))),
                  SizedBox(
                    height: 200,
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
                            formKey.currentState?.save();
                            if (title != '' && dec != '') {
                              formKey.currentState
                                  ?.reset(); //เคลียร์ฟอร์มเป็นค่าว่าง
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text("Success Your Todo has been saved"),
                                backgroundColor: Colors.green[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.00),
                                  ),
                                ),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("กรุณาเติมข้อความให้ครบถ้วน"),
                                backgroundColor: Colors.red,
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
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: Colors.transparent),
                          child: Text(
                            "Save",
                            style: GoogleFonts.outfit(
                              color: HexColor("#FFFFFF"),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ))),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
