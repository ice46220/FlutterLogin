import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controller/base_api.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/screen/register.dart';
import 'package:flutter_application_1/screen/widget/widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String mail ='',pass ='';

  TextEditingController inputemail = TextEditingController();
  TextEditingController inputpassword = TextEditingController();

  Future<void> login() async {
    String isSuccess = await CAllAPI().login(mail,pass);
    if(isSuccess == "OK"){
      formKey.currentState?.reset(); //เคลียร์ฟอร์มเป็นค่าว่าง
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) {
                return HomeScreen();
              }));
    }
    else{
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Exit App?'),
        content: const Text('Do you want to exit an App?  '),
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
          onTap: () => FocusScope.of(context).unfocus(), //คลิกเมาส์ที่อื่นเพื่อปิดคีย์บอร์ด
          child: WillPopScope(
            onWillPop: _onWillPop, //ปุ่มกลับบนคีย์บอร์ด
            child: Scaffold(
              backgroundColor: Colors.transparent, //สีพื้นหลังโปร่งใส
              body: Padding(
                padding: const EdgeInsets.fromLTRB(43, 0, 43, 0),
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 49,
                    ),
                    Text(
                      "SIGN IN",
                      style: GoogleFonts.outfit(
                        color: HexColor("#473B1E"),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                      image: Svg('assets/images/pic3special.svg'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFieldWidget(
                                    text:'Email' ,
                                    controller:inputemail ,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                          "Please enter your email"), //ดักค่าว่า
                                      EmailValidator(
                                          errorText: "Invalid email")
                                    ]),
                                    obscure: false,
                                    onSaved:  (String? email) {
                                       mail = email!;
                                    },
                                    textType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFieldWidget(
                                    text:'Password' ,
                                    controller:inputpassword ,
                                    validator: RequiredValidator(
                                        errorText: "Please enter your password"),
                                    obscure: true,
                                    onSaved:  (String? password) {
                                      pass = password!;
                                    },
                                    textType: TextInputType.text,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 3, 0, 0),
                                      child: Text(
                                        "Forgot Password ?",
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.outfit(
                                          color: HexColor("#2D2626"),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  ButtonWidget(
                                    textButton: "SIGN IN",
                                    press: () {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState?.save();
                                        print("email = ${mail} passsword = ${pass}");
                                        login();
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SecondButtonWidget(
                                    textButton:" SIGN UP",
                                    press:() {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) {
                                                return const RegisterScreen();
                                              }));
                                    },
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
        ),
      ),
    );
  }
}
