import 'package:test_interview/utils/module.dart';

class Components {
  static Material primaryButton({
    @required Color btnColor,
    @required Color textColor,
    @required VoidCallback onPressed,
    @required String text,
    @required BuildContext context,
  }) =>
      Material(
          color: btnColor,
          borderRadius: BorderRadius.circular(4.0),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                // fontWeight: FontWeight.bold,
                // fontSize: 10.0
              ),
            ),
            onPressed: onPressed,
          ));

  static Material secondButton({
    @required Color btnColor,
    @required Color textColor,
    @required VoidCallback onPressed,
    @required String text,
    @required BuildContext context,
  }) =>
      Material(
          color: btnColor,
          borderRadius: BorderRadius.circular(4.0),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width / 3,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                // fontWeight: FontWeight.bold,
                // fontSize: 10.0
              ),
            ),
            onPressed: onPressed,
          ));
}
