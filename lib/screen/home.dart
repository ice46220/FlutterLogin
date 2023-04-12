import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/base_api.dart';
import 'package:flutter_application_1/model/todolist.dart';
import 'package:flutter_application_1/screen/edit.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  String filter = '';
  String userName = '', userId = '';
  String firstChar = '';
  List<Todolist> data = [];
  List<Todolist> data2 = [];
  String searchData = '';
  @override
  void initState()  {
    //เซ็ตค่า ให้appbar
     getValidationData();
    super.initState();
  }

  Future<void> getValidationData() async {
    final SharedPreferences sharedPerferences =
        await SharedPreferences.getInstance();
    var name = sharedPerferences.getString("Fullname");
    var id = sharedPerferences.getString("Userid");
    setState(() {
      userName = name!;
      userId = id!;
      firstChar = userName[0].toUpperCase();
    });
  }

  Future<List<Todolist>> fetchData() async {
    //ดึงข้อมูล Todolist
    final todolist = await CAllAPI().get('todo_list/$userId');
    if (todolist != null) {
      final dataAPI =
          jsonDecode(todolist); //แปลง json(string/array) เป็น object
      data.clear();
      for (var index in dataAPI) {
        data.add(Todolist.fromJson(index));
      }

      return data;
    } 
    else {
      throw("Failed to load data");
    }
  }

  Future dialogSignout() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to Log out '),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen())), //ออกจากแอพ
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future dialogDelect(todoId) async {
    bool isSuccess = await CAllAPI().deleteTodos(todoId);
    if (isSuccess) {
      Navigator.pop(context);    //ออกจากไดอาล็อก
      Navigator.pop(context);     //ออกจาก
      setState(()
      //reloadหน้าเมื่อมีการเปลี่ยนแปลง
      {});
    }
  }

  Future<bool> _onWillPop() async {
     return (await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to Exit '),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () =>
                SystemNavigator.pop(), //ออกจากแอพ
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ??
      false;
  }

  List<Color> myColors = [
    HexColor("#0D7A5C"),
    HexColor("#FB9A2B"),
    HexColor("#355389"),
    HexColor("#F7A491"),
    HexColor("#3CB189"),
  ];

  Color _generateRandomColor() {
    Random random = Random();
    int index = random.nextInt(myColors.length);
    return myColors[index];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), //ทำให้เวลาคลิกที่อื่น คีย์บอร์ดจะหุบ
      child: WillPopScope(
        onWillPop: _onWillPop, //ต้องรีเทิร์นเป็น false เมื่อไม่ให้กดปุ่มย้อนกลับบนหน้าจอได้
        child: Scaffold(
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
                                  const SizedBox(
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
                                      const SizedBox(
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
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  ListTile(
                                    leading: const Image(
                                      width: 24,
                                      height: 24,
                                      image:
                                          Svg('assets/images/logoutcurve.svg'),
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
                                      // Navigator.pushReplacement(context, //ไม่อยากให้ User สามารถกลับไปยังหน้าแรกได้อีกเลย
                                      //     MaterialPageRoute(builder: (context) {
                                      //   return const HomeScreen();
                                      // }));
                                      dialogSignout();
                                    },
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: HexColor("#D9D9D9")),
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
                          firstChar,
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
                              Text(userName,
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
          body: FutureBuilder<List<Todolist>>(
            future: fetchData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //ถ้าดึงข้อมูลมาครบแล้ว
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  //มีค่าว่างไหม
                  return Center(
                    child: Container(
                        height:200,
                        width: 200,
                        decoration: const BoxDecoration(
                        //shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/nodata.png"),
                           ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Container(
                            height: 59,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: const [
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
                            cursorColor:
                                HexColor("#AEAEB2"), //สีเคอเซอร์ | ตอนแรกสีฟ้า
                            decoration: InputDecoration(
                                fillColor: HexColor("#FFFFFF"), //สีพื้นหลัง
                                filled:
                                    true, //ทำให้มีสีพื้นลัง ถ้าfalse จะไม่มีสี
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
                                  padding: const EdgeInsets.all(15),
                                  child: Image(
                                    image: Svg('assets/images/search.svg'),
                                  ),
                                  width: 18,
                                )),
                            onChanged: (value) {
                              setState(() {
                                searchData= value;
                              });
                            },
                          ),
                        ]),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  Todolist todo = data[index];
                                  print("length ${snapshot.data!.length}");

                                  //หาได้ทั้งพิมพ์เล็กพิมพ์ใหญ่
                                  if (searchData.isNotEmpty &&
                                      !todo.userTodoListTitle
                                          .toString()
                                          .toLowerCase()
                                          .contains(searchData.
                                              toLowerCase()) &&
                                      !todo.userTodoListTitle
                                          .toString()
                                          .toUpperCase()
                                          .contains(searchData
                                              .toUpperCase())) {
                                    return Container(); //return หน้าจอว่างกลับไป
                                  }
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(2, 8, 2, 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              //rgba(0, 0, 0, 0.2);0px 0px 6px
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.2),
                                              offset: Offset(0, 0),
                                              blurRadius: 6,
                                              spreadRadius: 0,
                                            ),
                                          ],
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 8),
                                        child: Stack(
                                          children:[
                                            ListTile(
                                            minLeadingWidth: 0,// Minimum width of leading
                                            horizontalTitleGap: 8.0,//Between title and leading
                                            minVerticalPadding: 10.0, //Between title and subtitle
                                            leading: (todo.userTodoListCompleted
                                                        .toString() ==
                                                    "true"
                                                ? Icon(
                                                    //ถ้า true
                                                    Icons.check_circle,
                                                    color: HexColor("#1DC9A0"),
                                                    size: 20,
                                                  )
                                                : Icon(
                                                    //ถ้า false
                                                    Icons.circle_outlined,
                                                    color: HexColor("#AEAEB2"),
                                                    size: 20,
                                                  )),
                                            title: Text(
                                              todo.userTodoListTitle.toString(),
                                              style: GoogleFonts.outfit(
                                                color: _generateRandomColor(),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  DateFormat('hh:mm a-dd/MM/yy')
                                                      .format(DateTime.parse(todo
                                                              .userTodoListLastUpdate
                                                              .toString())
                                                          .toLocal()),
                                                  style: GoogleFonts.outfit(
                                                    color: HexColor("#D9D9D9"),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Text(
                                                  todo.userTodoListDesc
                                                      .toString(),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.outfit(
                                                    color: const Color.fromRGBO(
                                                        102, 97, 97, 0.68),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                            Align(
                                              alignment: AlignmentDirectional.topEnd,
                                             child: Padding(
                                               padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                               child: InkWell(
                                                  child: const Icon(Icons.more_horiz,color: Color.fromRGBO(102, 97, 97, 0.68),),
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                        backgroundColor:
                                                        HexColor("#FBFBFB"),
                                                        context: context,
                                                        shape:
                                                        const RoundedRectangleBorder(
                                                          // <-- SEE HERE
                                                          borderRadius:
                                                          BorderRadius.vertical(
                                                            top:
                                                            Radius.circular(25.0),
                                                          ),
                                                        ),
                                                        builder: (context) {
                                                          return SizedBox(
                                                            height: 250,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      16,
                                                                      0,
                                                                      20),
                                                                  child: Center(
                                                                    child: Container(
                                                                      height: 3,
                                                                      width: 52,
                                                                      decoration:
                                                                      BoxDecoration(
                                                                        color: HexColor(
                                                                            "#D9D9D9"),
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            14.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      30,
                                                                      0,
                                                                      30,
                                                                      0),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      const SizedBox(
                                                                        height: 30,
                                                                      ),
                                                                      ListTile(
                                                                        leading:
                                                                        const Image(
                                                                          width: 24,
                                                                          height: 24,
                                                                          image: Svg(
                                                                              'assets/images/messageedit.svg'),
                                                                        ),
                                                                        title: Text(
                                                                          "Edit",
                                                                          style: GoogleFonts
                                                                              .outfit(
                                                                            color: HexColor(
                                                                                "#0D7A5C"),
                                                                            fontSize:
                                                                            16,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                          ),
                                                                        ),
                                                                        trailing:
                                                                        Icon(
                                                                          Icons
                                                                              .keyboard_arrow_right,
                                                                          color: HexColor(
                                                                              "#0D7A5C"),
                                                                        ),
                                                                        onTap: () {
                                                                          Navigator
                                                                              .push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder:
                                                                                  (context) =>
                                                                                  EditScreen(
                                                                                    todolist:
                                                                                    todo,
                                                                                  ),
                                                                            ),
                                                                          ).then(
                                                                                (value) =>
                                                                                setState(
                                                                                        () {
                                                                                          Navigator.pop(context);
                                                                                        }),
                                                                          );
                                                                        },
                                                                      ),
                                                                      Container(
                                                                        height: 1,
                                                                        width: double
                                                                            .infinity,
                                                                        decoration:
                                                                        BoxDecoration(
                                                                            color:
                                                                            HexColor("#D9D9D9")),
                                                                      ),
                                                                      ListTile(
                                                                        leading:
                                                                        const Image(
                                                                          width: 24,
                                                                          height: 24,
                                                                          image: Svg(
                                                                              'assets/images/trash.svg'),
                                                                        ),
                                                                        title: Text(
                                                                          "Delete",
                                                                          style: GoogleFonts
                                                                              .outfit(
                                                                            color: HexColor(
                                                                                "#0D7A5C"),
                                                                            fontSize:
                                                                            16,
                                                                            fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                          ),
                                                                        ),
                                                                        trailing:
                                                                        Icon(
                                                                          Icons
                                                                              .keyboard_arrow_right,
                                                                          color: HexColor(
                                                                              "#0D7A5C"),
                                                                        ),
                                                                        onTap:
                                                                            () async {
                                                                          print(todo.userTodoListId.toString());
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) =>AlertDialog(
                                                                                title: const Text('Are you sure?'),
                                                                                content: const Text('Do you want to Delete '),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                                    child: const Text('No'),
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () => {
                                                                                      dialogDelect(todo.userTodoListId.toString()),
                                                                                    }, //ออกจากแอพ
                                                                                    child: const Text('Yes'),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                          );
                                                                        },
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
                                           ),
                                        ]
                                        ),
                                      ),
                                    ),
                                  );
                                }))
                      ],
                    ),
                  ));
                }
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                ); //เก็บค่า error ของ throw ไว้ถ้าเกิด error ก็จะแสดง
              } else
                return LinearProgressIndicator(); // loadding
            },
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: HexColor("#0D7A5C"),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return AddTodoScreen();
                // }));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(
                      todolist: null,
                    ),
                  ),
                ).then(
                  (value) => setState(() {}),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: Svg('assets/images/pic6.svg'),
                ),
              )),
        ),
      ),
    );
  }
}
