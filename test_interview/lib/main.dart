import 'package:test_interview/utils/module.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TestScoped model = new TestScoped();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<TestScoped>(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "login": (BuildContext context) => Login(
                model: model,
              ),
          "home": (BuildContext context) => Home(model: model),
        },
        title: 'Test',
        theme: ThemeData(
          primaryColor: Color(0xFF253c7d),
          primarySwatch: MaterialColor(0xFF253c7d, const <int, Color>{
            50: const Color(0xFF253c7d),
            100: const Color(0xFF253c7d),
            200: const Color(0xFF253c7d),
            300: const Color(0xFF253c7d),
            400: const Color(0xFF253c7d),
            500: const Color(0xFF253c7d),
            600: const Color(0xFF253c7d),
            700: const Color(0xFF253c7d),
            800: const Color(0xFF253c7d),
            900: const Color(0xFF253c7d),
          }),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splashs(model: model),
      ),
    );
  }
}

class Splashs extends StatefulWidget {
  TestScoped model;
  Splashs({this.model});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Splashs> {
  @override
  void initState() {
    // TODO: implement initState
    startSplash();
    super.initState();
  }

  startSplash() async {
    return new Timer(Duration(seconds: 3), navigatePage);
  }

  void navigatePage() async {
    var cek = await widget.model.cekUser();
    print("Nilai Cek " + cek.toString());
    if (cek == true) {
      Navigator.pushReplacementNamed(context, "home");
    } else {
      Navigator.pushReplacementNamed(context, "login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(child: Image.asset(Utils.LOGO, width: 125, height: 125)));
  }
}
