import 'package:test_interview/utils/module.dart';

class Login extends StatefulWidget {
  TestScoped model;
  Login({
    @required this.model,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<Login> {
  TextEditingController email =
      new TextEditingController();
  TextEditingController password =
      new TextEditingController();
  bool hidden = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<TestScoped>(
      model: widget.model,
      child: Scaffold(
        body: Wrap(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 125.0, bottom: 125.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey[350], blurRadius: 20),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Center(
                        child: Image.asset(Utils.LOGO, width: 120, height: 120),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.3),
                            hintText: "Email",
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Email is empty";
                            } else {
                              if (!value.contains("@")) {
                                return "Email is invalid";
                              } else {
                                return null;
                              }
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: TextFormField(
                          obscureText: hidden,
                          controller: password,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.3),
                              hintText: "Password",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    hidden = !hidden;
                                  });
                                },
                              )),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password is empty";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Components.primaryButton(
                          text: "Login",
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              widget.model.loginUser(widget.model, context,
                                  email.text, password.text);
                            }
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           Home(model: widget.model)),
                            //   (Route<dynamic> route) => false,
                            // );
                            // widget.model.emailUser = email.text;
                            // widget.model.passUser = password.text;

                            // Navigator.pushReplacementNamed(
                            //     context, "otp_screen");
                          },
                          context: context,
                          btnColor: Colours.btnColor,
                          textColor: Colors.white,
                        ),
                      ),
                      // SizedBox(height: 16),
                      Padding(
                          padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Components.primaryButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Register(model: widget.model)));
                              },
                              text: "Register",
                              context: context,
                              btnColor: Colours.btnColor,
                              textColor: Colors.white)),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
