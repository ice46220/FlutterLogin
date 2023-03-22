import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_application_1/screen/register.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register/Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: SingleChildScrollView(
          child: Column(children: [
            Image(image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Kaito_Kid_signature.svg/648px-Kaito_Kid_signature.svg.png",scale: 3)),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: 
                    (context){
                      return RegisterScreen();
                    }));
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    "Sign up",
                    style: TextStyle(fontSize: 30),
                  )),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                  icon: Icon(Icons.login),
                  label: Text(
                    "Sign in",
                    style: TextStyle(fontSize: 30),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
