import 'package:test_interview/utils/module.dart';

class Register extends StatefulWidget {
  TestScoped model;
  Register({
    @required this.model,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _confirmpassword = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool hidden = true, hidePass = true;
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
                padding: EdgeInsets.only(
                    left: 20, right: 20, top: 125.0, bottom: 125.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.grey[350], blurRadius: 20)
                      ]),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 8.0),
                        Padding(
                          padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: TextFormField(
                            controller: _name,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.3),
                              hintText: "Name",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (vals) {
                              if (vals.isEmpty) {
                                return "Your name is empty";
                              } else if (vals.length < 3) {
                                return "Your name is invalid";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.3),
                              hintText: "Email",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.mail),
                            ),
                            validator: (vals) {
                              if (vals.isEmpty) {
                                return "Your email is empty";
                              } else if (!vals.contains("@")) {
                                return "Your email is invalid";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: TextFormField(
                            obscureText: hidden,
                            controller: _password,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                // border: OutlineInputBorder(
                                //     borderRadius: BorderRadius.circular(10.0)),
                                fillColor: Colors.grey.withOpacity(0.3),
                                filled: true,
                                hintText: "Password",
                                // border: InputBorder.none,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() {
                                      hidden = !hidden;
                                    });
                                  },
                                )),
                            validator: (val) {
                              if (val.contains(" ")) {
                                return "Your password is invalid";
                              } else if (val.isEmpty) {
                                return "Your password is empty";
                              } else if (val != _confirmpassword.text) {
                                return "Your password is not same";
                              } else if (val.length < 5) {
                                return "Your password is weak";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: TextFormField(
                            obscureText: hidePass,
                            controller: _confirmpassword,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey.withOpacity(0.3),
                                hintText: "Confirm Password",
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() {
                                      hidePass = !hidePass;
                                    });
                                  },
                                )),
                            validator: (val) {
                              if (val.contains(" ")) {
                                return "Your password is invalid";
                              } else if (val.isEmpty) {
                                return "Your confirm password is empty";
                              } else if (val != _password.text) {
                                return "Your password is not same";
                              } else if (val.length < 5) {
                                return "Your password is too weak";
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
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  widget.model.registerUser(
                                      widget.model,
                                      context,
                                      // URL.PROFILE_PICTURE,
                                      _name.text,
                                      _email.text,
                                      _password.text);
                                }
                              },
                              text: "Register",
                              context: context,
                              btnColor: Colours.btnColor,
                              textColor: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Components.primaryButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Login(model: widget.model)),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              text: "Cancel",
                              context: context,
                              btnColor: Colours.disableColor.withOpacity(0.2),
                              textColor: Colours.disableColor),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
