import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// get
class CAllAPI {
  final client = http.Client();
  final baseUrl = "http://bms.dyndns.tv:6004/api/";
  final token = "950b88051dc87fe3fcb0b4df25eee676";

  static String userName = "";
  static String userID = "";

  //set headers
  dynamic getHeaders() {
    final header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    return header;
  }

  // get
  Future<dynamic> get(String endpoint) async {
    try {
      final url = Uri.parse(baseUrl + endpoint);
      //log(url.toString());
      final response = await client.get(url, headers: getHeaders());
      if (response.statusCode == 200) {
        log(response.body);
        return response.body;
      }
    } catch (e) {
      log("decode json error=>$e");
      //snakbar
    }

    return null;
  }

// login api
  Future<String> login(String userName, passWord) async {
    String passed ="";

    final payload = {
      'user_email': userName,
      'user_password': passWord,
    };

    log("payload:${jsonEncode(payload)}"); //แปรง object เป็น json

    final url = Uri.parse('${baseUrl}login');

    final response = await client.post(url,
        body: jsonEncode(payload), headers: getHeaders());

    try {
      if (response.statusCode == 200) {
        final body = response.body;
        final data = jsonDecode(body); //แปลงข้อมูลเอาไปใช้ JSON string to an object.

        userID = data["user_id"].toString();
        userName = data["user_fname"] + " " + data["user_lname"];
        final SharedPreferences sharedPerferences = //เก็บค่าชื่อ
            await SharedPreferences.getInstance();
        sharedPerferences.setString(
            'Fullname', userName); //setค่าไปหน้า homeเพื่อเรียกชื่อ
        sharedPerferences.setString('Userid', userID); //เก็บค่า id

        return passed = "OK";
      }
      else{
        final body = response.body;
        final data = jsonDecode(body);
        return  passed = data["message"].toString();
      }
    } catch (e) {
      log("decode json error=>$e");
      return "decode json error=>$e";
    }
  }

  //delete
  Future<bool> deleteTodos(String id) async {
    try {
      final url = Uri.parse('${baseUrl}delete_todo/$id');
      final response = await http.delete(url, headers: getHeaders());
      return response.statusCode == 200;
    } catch (e) {
      log("decode json error=>$e");
    }
    return false;
  }

  // add todo
  // ignore: non_constant_identifier_names
  Future<bool> addTodos(String title, desc, bool isSuccess) async {
    try {
      final successStatus = isSuccess.toString();
      //'true'
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final userId = sharedPreferences.getString('Userid');

      final payload = {
        "user_todo_list_title": title,
        "user_todo_list_desc": desc,
        "user_todo_list_completed": successStatus,
        "user_id": userId,
      };

      log("payload:${jsonEncode(payload)}");

      final url = Uri.parse('${baseUrl}create_todo');

      final response = await client.post(url,
          body: jsonEncode(payload), headers: getHeaders());
      log("$response.statusCode");
      return response.statusCode == 200;
    } catch (e) {
      log("decode json error=>$e");
    }
    return false;
  }

  // update toto
  // ignore: non_constant_identifier_names
  Future<bool> UpdateTodos(
      String id, title, desc, userId, bool isSuccess) async {
    try {
      final successStatus = isSuccess.toString();

      final payload = {
        "user_todo_list_id": id,
        "user_todo_list_title": title,
        "user_todo_list_desc": desc,
        "user_todo_list_completed": successStatus,
        "user_id": userId,
      };

      log("payload:${jsonEncode(payload)}");

      final url = Uri.parse('${baseUrl}update_todo');

      final response = await client.post(url,
          body: jsonEncode(payload), headers: getHeaders());
      print(response.statusCode);
      return response.statusCode == 200;
    } catch (e) {
      log("decode json error=>$e");
    }
    return false;
  }

  //create user
  Future<dynamic> createUser(String firstName, lname, email, passWord) async {
    String message ='';
    try {
      final payload = {
        "user_email": email,
        "user_password": passWord,
        "user_fname": firstName,
        "user_lname": lname
      };

      log("payload:${jsonEncode(payload)}");

      final url = Uri.parse('${baseUrl}create_user');
      log(url.toString());

      final response = await client.post(url,
          headers: getHeaders(), body: jsonEncode(payload));

      log("response ${response.statusCode} ");
      log("response ${response.body}");

      if(response.statusCode == 200){
        return message = "OK";
      }
      else{
        final data = jsonDecode(response.body);
        message = data["message"].toString();
      }
      return message;
    } catch (e) {
      log("decode json error=>$e");
      return "$e";
    }
  }
}
