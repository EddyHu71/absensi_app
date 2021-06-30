import 'package:test_interview/utils/module.dart';
import 'package:intl/intl.dart';

class Formatter {
  String formatDate(String dates) {
    final dateFormat = DateFormat("dd/MM/yyyy");
    return dateFormat.format(DateTime.parse(dates));
  }

  String formatHour(String duration) {
    if (double.parse(duration) > 1) {
      return duration + " hours";
    } else if (double.parse(duration) == 1) {
      return duration + " hour";
    } else {
      return "";
    }
  }

  String formatMinute(String duration) {
    if (double.parse(duration) > 1) {
      return duration + " minutes";
    } else if (double.parse(duration) == 1) {
      return duration + " minute";
    } else {
      return "";
    }
  }
}

final formatter = Formatter();
