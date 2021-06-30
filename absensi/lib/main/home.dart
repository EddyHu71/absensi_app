import 'package:test_interview/utils/module.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  TestScoped model;
  Home({
    this.model,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  DateFormat dateFormat = new DateFormat("yyyy-MM-dd");

  void alertKeluar() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure want to log out?"),
            actions: [
              FlatButton(
                  onPressed: () {
                    widget.model.logoutuser(context, widget.model);
                    // Navigator.pushReplacementNamed(context, "login");
                  },
                  child: Text("Yes")),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No")),
            ],
          );
        });
  }

  @override
  void initState() {
    widget.model.authAbsen();
    widget.model.getListAttendance("", "");
    // widget.model.getListAttendance();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModelDescendant<TestScoped>(builder: (context, build, model) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Test"),
            actions: [
              IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    alertKeluar();
                  })
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                          model.contentLogin.users.nameUser.toString() == ""
                              ? "Hello, Nama"
                              : "Hello, " +
                                  model.contentLogin.users.nameUser.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Components.secondButton(
                                  btnColor: widget.model.authabsen == "0"
                                      ? Colours.btnColor
                                      : Colours.disableColor,
                                  textColor: widget.model.authabsen == "0"
                                      ? Colors.white
                                      : Colors.black,
                                  onPressed: () {
                                    // widget.model.authabsen == "1" ??
                                    //     widget.model.absensiIn();
                                  },
                                  text: "Absent In",
                                  context: context),
                            ),
                            Expanded(
                              child: SizedBox(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Components.secondButton(
                                  btnColor: widget.model.authabsen == "1"
                                      ? Colours.btnColor
                                      : Colours.disableColor,
                                  textColor: widget.model.authabsen == "1"
                                      ? Colors.white
                                      : Colors.black,
                                  onPressed: () {
                                    // widget.model.authabsen == "0" ??
                                    //     widget.model.absensiOut();
                                  },
                                  text: "Absent Out",
                                  context: context),
                            ),
                          ],
                        )),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Components.primaryButton(
                          btnColor: Colours.btnColor,
                          textColor: Colors.white,
                          onPressed: () async {
                            final List<DateTime> picked =
                                await DateRangePicker.showDatePicker(
                                    context: context,
                                    initialFirstDate: new DateTime.now(),
                                    initialLastDate: (new DateTime.now())
                                        .add(new Duration(days: 7)),
                                    firstDate: new DateTime(1990),
                                    lastDate:
                                        new DateTime(DateTime.now().year + 2));
                            if (picked != null && picked.length == 2) {
                              widget.model.getListAttendance(
                                  dateFormat.format(picked[0]),
                                  dateFormat.format(picked[1]));

                              print(dateFormat.format(picked[0]));
                              print(dateFormat.format(picked[1]));
                            }
                          },
                          text: "Pick Date Range",
                          context: context),
                    ),
                  ),
                  widget.model.attendances == true
                      ? SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()))
                      : widget.model.listattendance.length == 0
                          ? SliverToBoxAdapter(
                              child: Center(
                                  child: Text("No Attendance History",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey,
                                      ))))
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                return ListTile(
                                    title: Text(
                                        widget.model.listattendance[index].name
                                                    .toString() ==
                                                ""
                                            ? "Nama"
                                            : widget.model.listattendance[index]
                                                .name
                                                .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(formatter.formatDate(widget
                                                .model
                                                .listattendance[index]
                                                .tanggal)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Text(
                                                  widget
                                                          .model
                                                          .listattendance[index]
                                                          .absenIn +
                                                      " - " +
                                                      widget
                                                          .model
                                                          .listattendance[index]
                                                          .absenOut,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        )),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Lama Kerja : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  formatter.formatHour(widget
                                                      .model
                                                      .listattendance[index]
                                                      .jamLamaKerja),
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              // Expanded(child: SizedBox()),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Text(
                                                    formatter.formatMinute(
                                                        widget
                                                            .model
                                                            .listattendance[
                                                                index]
                                                            .menitLamaKerja),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ));
                              },
                                  childCount:
                                      widget.model.listattendance.length),
                            )
                ],
              )));
    });
  }
}
