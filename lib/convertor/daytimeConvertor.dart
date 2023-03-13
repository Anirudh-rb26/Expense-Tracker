// convert DateTime object to string ddmmyyyy

String convertDateTimeToString(DateTime dateTime) {

  // year -> yyyy
  String year = dateTime.year.toString();

  // month -> mm
  String month = dateTime.month.toString();

  // if month = 3, if statement makes month = 03
  if (month.length == 1) {
    month = '0$month';
  }

  // day -> dd
  String day = dateTime.day.toString();

  // if day = 3, if statement makes day = 03
  if (day.length == 1) {
    day = '0$day';
  }
  
  // final format ddmmyyyy
  String ddmmyyyy = day + month + year;
  return ddmmyyyy;
}
