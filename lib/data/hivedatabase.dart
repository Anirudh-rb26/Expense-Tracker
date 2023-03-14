import 'package:hive_flutter/adapters.dart';
import 'package:expensetracker/models/expenseitems.dart';

class HiveDataBase {
  // reference our Box
  final _myBox = Hive.box("expensedatabase");

  // write data
  void saveData(List<ExepenseItem> allExpense) {
    /*
    hive can only save data in from of strings and DateTime
    so converting expenseItem into types that can be stored in hive

    allExpense = [ ExepenseItem(name / amount / dateTime)]    ->    [name, amount, dateTime]
    */

    List<List<dynamic>> allExpensesFormatted = [];
    for (var expense in allExpense) {
      // convert each of the expenseItem to a list of storable type (strings, dateTime)
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];

      allExpensesFormatted.add(expenseFormatted);
    }

    // storing data in database
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  // reading data
  List<ExepenseItem> readData() {
    /* 
    Data stored in hive as a list of strings + dateTime
    convert saved data into expenseItem

    savedData =[[name, amount, dateTime]]   ->    ExpenseItem(name, amount, dateTime)
    */

    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExepenseItem> allExpenses = [];

    for (int index = 0; index < savedExpenses.length; index++) {
      // collect individual expense data
      String name = savedExpenses[index][0];
      String amount = savedExpenses[index][1];
      DateTime dateTime = savedExpenses[index][2];

      // create expenseItem
      ExepenseItem expense = ExepenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      allExpenses.add(expense);
    }

    return allExpenses;
  }
}
