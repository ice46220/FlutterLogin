import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/addtodo.dart';
import 'package:flutter_application_1/screen/edit.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/profile.dart';
import 'package:intl/intl.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile =
      Profile(email: '', password: '', firstName: '', lastName: '');
  Map<String, String> dataTest = {
    "user_todo_list_id": "1714",
    "user_todo_list_title": "cat",
    "user_todo_list_desc": "AI Appication.",
    "user_todo_list_completed": "true",
    "user_todo_list_last_update": "2023-03-23T02:18:24.000Z",
    "user_id": "350",
    "user_todo_type_id": "1",
    "user_todo_type_name": "Pascal"
  };
  var allDate = DateFormat("hh:mm a-MM/dd/yy").format(
      DateFormat('yyyy-MM-ddTHH:mm:ss').parse("2023-03-23T02:18:24.000Z"));
  var allDate2 = DateFormat.yMd().format(
      DateFormat('yyyy-MM-ddTHH:mm:ss').parse("2023-03-23T02:18:24.000Z"));

  TextEditingController searchController = new TextEditingController();
  String filter = '';
  @override  initState() {
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //ปิดศรย้อน
        title: GestureDetector(
          onTap: () {
            showModalBottomSheet(
                backgroundColor: HexColor("#FBFBFB"),
                context: context,
                shape: const RoundedRectangleBorder(
                  // <-- SEE HERE
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                builder: (context) {
                  return SizedBox(
                    height: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 20),
                          child: Center(
                            child: Container(
                              height: 3,
                              width: 52,
                              decoration: BoxDecoration(
                                color: HexColor("#D9D9D9"),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Center(
                                  child: Column(
                                children: [
                                  Text("SIGN OUT",
                                      style: GoogleFonts.outfit(
                                        color: HexColor("#473B1E"),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Do you want to log out?",
                                      style: GoogleFonts.outfit(
                                        color: HexColor("#473B1E"),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              )),
                              SizedBox(
                                height: 30,
                              ),
                              ListTile(
                                leading: Image(
                                  width: 24,
                                  height: 24,
                                  image: Svg('assets/images/logoutcurve.svg'),
                                ),
                                title: Text(
                                  "Signout",
                                  style: GoogleFonts.outfit(
                                    color: HexColor("#0D7A5C"),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: HexColor("#0D7A5C"),
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                        return HomeScreen();
                                      }));
                                },
                              ),
                              Container(
                                height: 1,
                                width: double.infinity,
                                decoration:
                                    BoxDecoration(color: HexColor("#D9D9D9")),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: HexColor("#FBFBFB"),
                    child: Text(
                      "P",
                      style: GoogleFonts.outfit(
                        color: HexColor("#53CD9F"),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello!",
                              style: GoogleFonts.outfit(
                                color: HexColor("##FFFFFF"),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              )),
                          Text("Panjira Aungsupanich",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.outfit(
                                color: HexColor("##FFFFFF"),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
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
      body: Container(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                height: 59,
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      //  rgba(0, 0, 0, 0.25); 0px 1px 4px
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 1),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
              TextField(
                controller: searchController,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 15,
                  color: HexColor("#AEAEB2"),
                  fontWeight: FontWeight.w500,
                ),
                cursorColor: HexColor("#AEAEB2"), //สีเคอเซอร์ | ตอนแรกสีฟ้า
                decoration: InputDecoration(
                    fillColor: HexColor("#FFFFFF"), //สีพื้นหลัง
                    filled: true, //ทำให้มีสีพื้นลัง ถ้าfalse จะไม่มีสี
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    hintText: ' Search.......',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: HexColor("#AEAEB2"),
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: Container(
                      padding: EdgeInsets.all(15),
                      child: Image(
                        image: Svg('assets/images/search.svg'),
                      ),
                      width: 18,
                    )),
                onTap: () {},
              ),
            ]),
            SizedBox(
              height: 15,
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          //rgba(0, 0, 0, 0.2);0px 0px 6px
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                          offset: Offset(0, 0),
                          blurRadius: 6,
                          spreadRadius: 0,
                        ),
                      ],
                      color: Colors.white),
                  child: ListTile(
                    leading: Icon(
                      Icons.check_circle,
                      color: HexColor("#1DC9A0"),
                    ),
                    title: Text(
                      dataTest[
                          'user_todo_list_title']!, // ! มันมีค่าเสมอแน่นอน ไม่null
                      style: GoogleFonts.outfit(
                        color: HexColor("#0D7A5C"),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allDate,
                          style: GoogleFonts.outfit(
                            color: HexColor("#D9D9D9"),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          dataTest["user_todo_list_desc"]!,
                          style: GoogleFonts.outfit(
                            color: Color.fromRGBO(102, 97, 97, 0.68),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    trailing: InkWell(
                      child: Icon(Icons.more_horiz),
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: HexColor("#FBFBFB"),
                            context: context,
                            shape: const RoundedRectangleBorder(
                              // <-- SEE HERE
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            builder: (context) {
                              return SizedBox(
                                height: 250,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 16, 0, 20),
                                      child: Center(
                                        child: Container(
                                          height: 3,
                                          width: 52,
                                          decoration: BoxDecoration(
                                            color: HexColor("#D9D9D9"),
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 0, 30, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 30,
                                          ),
                                          ListTile(
                                            leading: Image(
                                              width: 24,
                                              height: 24,
                                              image: Svg(
                                                  'assets/images/messageedit.svg'),
                                            ),
                                            title: Text(
                                              "Edit",
                                              style: GoogleFonts.outfit(
                                                color: HexColor("#0D7A5C"),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: HexColor("#0D7A5C"),
                                            ),
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return EditScreen();
                                              }));
                                            },
                                          ),
                                          Container(
                                            height: 1,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: HexColor("#D9D9D9")),
                                          ),
                                          ListTile(
                                            leading: Image(
                                              width: 24,
                                              height: 24,
                                              image: Svg(
                                                  'assets/images/trash.svg'),
                                            ),
                                            title: Text(
                                              "Delete",
                                              style: GoogleFonts.outfit(
                                                color: HexColor("#0D7A5C"),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.keyboard_arrow_right,
                                              color: HexColor("#0D7A5C"),
                                            ),
                                            onTap: () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor("#0D7A5C"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddTodoScreen();
            }));
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              image: Svg('assets/images/pic6.svg'),
            ),
          )),
    );
  }
}
