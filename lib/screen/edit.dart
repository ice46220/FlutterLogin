import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/base_api.dart';
import 'package:flutter_application_1/model/todolist.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/screen/widget/widget.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';

class EditScreen extends StatefulWidget {
   EditScreen({
    super.key,
    required this.todolist,
  });

  Todolist? todolist;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  bool isSwitched = false;
  TextEditingController title = TextEditingController();
  TextEditingController dec = TextEditingController();
  String idTodo = '';
  String userIdTodo = '';
  @override
  void initState() {
    super.initState();
    if(widget.todolist != null) {
      title.text = widget.todolist!.userTodoListTitle.toString();
      dec.text = widget.todolist!.userTodoListDesc.toString();
      isSwitched =
          widget.todolist!.userTodoListCompleted.toLowerCase() == "true";
      idTodo = widget.todolist!.userTodoListId.toString();
      userIdTodo = widget.todolist!.userId.toString();
    }
  }

  void snackShowGreen (text) {
     ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      content: Text(text),
       duration: const Duration(seconds: 1),
      backgroundColor: Colors.green[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.00),
        ),
      ),
    ));
  }
  void snackShowRed (text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar( content: Text(text),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.00),
        ),
      ),
    ));
  }

  Future<void> updateTodo() async {
    bool isSuccess = await CAllAPI().UpdateTodos(
        idTodo, title.text, dec.text, userIdTodo, isSwitched);
    if (isSuccess) {
      Navigator.pop(context);
      snackShowGreen("Success Your Todo has been saved");
    } else {
      snackShowRed("Error");
    }
  }


  Future<void> addTodo() async {
    bool isSuccess =
    await CAllAPI().addTodos(title.text, dec.text, isSwitched);
    if (isSuccess) {
      snackShowGreen("Success Your Todo has been saved");
      Navigator.pop(context);
    } else {
      snackShowRed("Error");
    }
  }

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
                          return HomeScreen();
                        }));
                      },
                      child: const Image(
                        width: 40,
                        height: 40,
                        image: Svg('assets/images/vector.svg'),
                      ),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    Text((widget.todolist == null ? "Add Your Todo":"Your Todo" ) ,
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
              stops: const [0.05, 1.84],
              transform: const GradientRotation(172.65 * 3.14 / 180),
            ),
            boxShadow: const [
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
                const SizedBox(
                  height: 15,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SecondTextFieldWidget(
                        text: "Title",
                        controller: title,
                        onSaved: (String? titleDec) {
                          title.text = titleDec!;
                        },
                        line: 1,
                        height: 60,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SecondTextFieldWidget(
                        text: "Decription",
                        controller: dec,
                        onSaved: (String? decription) {
                          dec.text = decription!;
                        },
                        line: 10,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
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
                                    });
                                  },
                                  thumbColor: Colors.white,
                                  activeColor: HexColor("#3CB189"),
                                  trackColor: Color.fromRGBO(0, 0, 0, 0.17),
                                ),
                              ))),
                      const SizedBox(
                        height: 35,
                      ),
                      ButtonWidget(
                        textButton: "Save",
                        press: () {
                          formKey.currentState?.save();
                          if (title.text != '' && dec.text != '') {
                            // formKey.currentState
                            //     ?.reset(); //เคลียร์ฟอร์มเป็นค่าว่าง
                            widget.todolist == null ?   addTodo()  : updateTodo();
                          }
                          else {
                            String mes = "data";
                            if(title.text == '' && dec.text !="") mes = "title";
                            else if (dec.text == '' && title.text != '') mes = "decription";
                            snackShowRed("Please enter your $mes");
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
