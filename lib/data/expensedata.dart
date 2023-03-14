import 'package:expensetracker/convertor/daytimeConvertor.dart';
import 'package:expensetracker/models/expenseitems.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  // List of expenseItems
  List<ExepenseItem> overallExpenseList = [];

  // method to return expenseList when we pull it
  List<ExepenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //method to add a new expense
  void addExpense(ExepenseItem expense) {
    overallExpenseList.add(expense);
    notifyListeners();
  }

  // function to delete expense
  void deleteExpense(ExepenseItem expense) {
    overallExpenseList.remove(expense);
  }

  // to get weekday
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return '';
    }
  }

  // to get start of the week
  DateTime startOfTheWeekDate() {
    DateTime? startOfWeek;

    //get todays date
    DateTime today = DateTime.now();

    // going backwards to find the nearest sunday
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sunday') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  //need to list all expenses
  // get exepenselist
  // add and delete expenses
  // get weekday
  // get date for start of the week

  /*
  convert expense data to expense summary

  overallExpenseList = [
    [food, 2023/01/30, $15]
    [lend, 2023/01/30, $25]
    [shoes, 2023/01/31, $45]
    [drink, 2023/01/31, $15]
    [clothes, 2023/02/01, $55]
  ]

  ->

  dailyExpenseSummary = [
    [2023/01/30: $40]
    [2023/01/301 $60]
    [2023/02/01: $55]
  ]
  */

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }
}
