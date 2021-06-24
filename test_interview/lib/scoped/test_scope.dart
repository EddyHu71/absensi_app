import 'package:test_interview/utils/module.dart';
import 'package:http/http.dart' as http;

class TestScoped extends Model {
  var _login = true;
  var _register = true;
  var _logout = true;
  var _attendance = true;
  String _authAbsen = "";
  final _listAttendance = List<Attendance>();
  ContentLogin _contentlogin;

  ContentLogin get contentLogin {
    return _contentlogin;
  }

  get login {
    return _login;
  }

  get register {
    return _register;
  }

  get logout {
    return _logout;
  }

  get attendances {
    return _attendance;
  }

  get authabsen {
    return _authAbsen;
  }

  List<Attendance> get listattendance {
    return _listAttendance;
  }

  validate(String route, bool condition) {
    switch (route) {
      case "login":
        _login = condition;
        break;
      case "register":
        _register = condition;
        break;
      case "logout":
        _logout = condition;
        break;
      case "list_attendance":
        _attendance = condition;
        break;
    }
    notifyListeners();
  }

  cekUser() async {
    print("Cek login executed");
    var token = await storages.showToken();
    print("Nilai token " + token);
    if (token == null) {
      print("Token false");
      return false;
    } else {
      var data = await http.post(Utils.URL + "get_test.php", body: {
        "post": "cek_login",
        "token_login": token,
      });
      print("Token true");
      var jsons = json.decode(data.body);
      print(jsons);
      if (jsons['status_login'] == "200") {
        storages.doSaveToken(token: jsons['token_login']);
        _contentlogin = ContentLogin.fromJson(jsons);
        return true;
      } else {
        return false;
      }
    }
  }

  loginUser(TestScoped model, context, String email, String password) async {
    validate("login", true);
    print("Login executed");
    var data = await http.post(Utils.URL + "get_test.php", body: {
      "post": "login_user",
      "email_login": email,
      "pass_login": password,
    });
    var jsons = json.decode(data.body);
    print(jsons);
    if (jsons['status_login'] == "200") {
      Toast.show("Login Success", context, duration: Toast.LENGTH_LONG);
      print("Login success");
      storages.doSaveToken(token: jsons['token_login']);
      _contentlogin = ContentLogin.fromJson(jsons);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false,
      );
    } else if (jsons['status_login'] == "banned") {
      Toast.show("Your account has been banned", context,
          duration: Toast.LENGTH_LONG);
    } else if (jsons['status_login'] == "invalid_user") {
      Toast.show("Your account has been logged in", context,
          duration: Toast.LENGTH_LONG);
    }

    validate("login", false);
  }

  registerUser(TestScoped model, BuildContext context, String name,
      String email, String password) async {
    validate("register", true);
    var data = await http.post(Utils.URL + "get_test.php", body: {
      "post": "register_user",
      "register_name": name,
      "register_email": email,
      "register_pass": password,
    });
    var jsons = json.decode(data.body);
    print(jsons);
    if (jsons["status"] == "register_berhasil") {
      Toast.show("Register Success", context, duration: Toast.LENGTH_LONG);
      print("Register success");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login(model: model)),
        (Route<dynamic> route) => false,
      );
      print("Register success");
    } else if (jsons["status"] == "email_taken") {
      Toast.show("Email has been used", context, duration: Toast.LENGTH_LONG);
      print("Email has been used");
    } else {
      Toast.show("Register failed", context, duration: Toast.LENGTH_LONG);
      print("Register failed");
    }
    validate("register", false);
  }

  logoutuser(BuildContext context, TestScoped model) async {
    validate("logout", true);
    var token = await storages.showToken();
    print("Token Logout " + token);
    var data = await http.post(Utils.URL + "get_test.php", body: {
      "post": "logout_user",
      "logout_id_user": contentLogin.users.idUser,
      "logout_token_user": token,
    });
    var jsons = json.decode(data.body);
    print(jsons);
    if (jsons == "logout_success") {
      storages.deleteAllWhenLogout();
      Toast.show("Logout Success", context, duration: Toast.LENGTH_LONG);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login(model: model)),
        (Route<dynamic> route) => false,
      );
    } else {
      Toast.show("Logout Failed", context, duration: Toast.LENGTH_LONG);
    }
    validate("logout", false);
  }

  getListAttendance(String checkIn, String checkOut) async {
    validate("list_attendance", true);
    print("Get List");
    listattendance.clear();
    var token = await storages.showToken();
    var data = await http.post(Utils.URL + "get_data.php", body: {
      "get_api": "get_list",
      "get_token_login": token,
      "check_date_in": checkIn,
      "check_date_out": checkOut,
    });
    var jsons = jsonDecode(data.body);
    print(jsons);
    if (jsons['status'] == "200") {
      jsons['data'].forEach((x) {
        final attend = Attendance.fromJson(x);
        listattendance.add(attend);
      });
    }
    validate("list_attendance", false);
  }

  authAbsen() async {
    validate("auth_absen", true);
    print("Auth Absen executed");
    var token = await storages.showToken();
    var data = await http.post(Utils.URL + "get_data.php", body: {
      "get_api": "auth_absen",
      "get_token_login": token,
      "id_user": contentLogin.users.idUser,
    });
    var jsons = json.decode(data.body);
    print("Auth absen " + _authAbsen);
    print(jsons);
    if (jsons['status'] == "no_absen") {
      print("No Absen");
      _authAbsen = "0";
    } else if (jsons['status'] == "absen_out") {
      print("Absen Out");
      _authAbsen = "1";
    }
    validate("auth_absen", false);
  }
}
