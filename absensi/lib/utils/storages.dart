import 'package:test_interview/utils/module.dart';

class Storages {
  final storage = new FlutterSecureStorage();
  doSaveToken({@required String token}) async {
    await storage.write(key: "token", value: token);
  }

  showToken() async {
    String token = await storage.read(key: "token");
    return token;
  }

  deleteAllWhenLogout() async {
    await storage.delete(key: "token");
    print("Log out");
  }

  cekToken() async {
    String token = await storage.read(key: "token");

    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}

final storages = Storages();
