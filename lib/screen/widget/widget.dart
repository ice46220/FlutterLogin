import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

//ช่องอีเมล พาส ชื่อ นามสกล
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    required this.text,
    this.controller,
    required this.validator,
    required this.onSaved,
    required this.textType,
    required this.obscure,
  });

  final String text;
  void Function(String?)? onSaved;
  final TextEditingController? controller;
  String? Function(String?)? validator;
  TextInputType textType;
  bool obscure;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: const [
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
          controller: controller,
          maxLines: 1,
          validator: validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: HexColor("#F3F3F3"),
            hintText: text,
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
          obscureText: obscure,
          keyboardType: textType,
          onSaved: onSaved
        ),
      ],
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
////////////////////////////////////////////////////////////////////////////////////////////
//ปุ่มกด
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.textButton,
    required this.press,
  });
  final String textButton;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              HexColor("#53CD9F"),
              HexColor("#0D7A5C"),
            ],
            begin:  FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            stops: const [0.0, 1.0],
            //transform: GradientRotation(180 * 3.14 / 180), //กลับหัว
          ),
        ),
        child: ElevatedButton(
            onPressed: press,
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Colors.transparent
            ),
            child: Text(
              textButton,
              style: GoogleFonts.outfit(
                color: HexColor("#FFFFFF"),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            )
        )
    );
  }
}

class SecondButtonWidget extends StatelessWidget {
  const SecondButtonWidget({
    super.key,
    required this.textButton,
    required this.press,
  });
  final String textButton;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              HexColor("#0D7A5C"),
              HexColor("#00503E"),
            ],
            begin:  FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            stops: const [0.0, 1.0],
            //transform: GradientRotation(180 * 3.14 / 180), //กลับหัว
          ),
        ),
        child: ElevatedButton(
            onPressed: press,
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Colors.transparent
            ),
            child: Text(
              textButton,
              style: GoogleFonts.outfit(
                color: HexColor("#FFFFFF"),
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            )
        )
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////
//หน้าEdit
class SecondTextFieldWidget extends StatelessWidget {
  SecondTextFieldWidget({
    super.key,
    required this.text,
    this.controller,
    required this.onSaved,
    this.line,
    required this.height,
  });

  final String text;
  void Function(String?)? onSaved;
  final TextEditingController? controller;
  int? line;
  double? height;

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(10.0),
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
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: TextFormField(
            controller: controller,
            style: GoogleFonts.outfit(
              color: Color.fromRGBO(102, 97, 97, 0.68),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            maxLines: line,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              hintStyle: GoogleFonts.outfit(
                color: Color.fromRGBO(102, 97, 97, 0.68),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onSaved: onSaved

          ),
        ));
  }
}

