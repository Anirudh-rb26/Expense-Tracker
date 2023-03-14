import 'package:expensetracker/components/expensesummary.dart';
import 'package:expensetracker/components/expensetile.dart';
import 'package:expensetracker/data/expensedata.dart';
import 'package:expensetracker/models/expenseitems.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add Expense"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // expense name
                  TextField(
                    controller: newExpenseNameController,
                    decoration: const InputDecoration(
                        hintText: "Where did you spend the money?"),
                  ),
                  // expense amount
                  TextField(
                    controller: newExpenseAmountController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(
                      hintText: "Amount",
                    ),
                  ),
                ],
              ),
              actions: [
                // save button
                MaterialButton(
                  onPressed: save,
                  child: const Text("Save"),
                ),

                // cancel button
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("Cancel"),
                ),
              ],
            ));
  }

  void save() {
    // creating expense item
    ExepenseItem newExpense = ExepenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );
    // adding the new expense item
    Provider.of<ExpenseData>(context, listen: false).addExpense(newExpense);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // to clear controllers or when you add new expense, old information already entered into textfield
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addExpense,
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
          ),
          body: ListView(
            children: [
              // weekly summary
              ExpenseSummary(startOfWeek: value.startOfTheWeekDate()),

              const SizedBox(height: 20),

              // expense list
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpenseList().length,
                  itemBuilder: (context, index) => ExpenseTile(
                      name: value.getAllExpenseList()[index].name,
                      amount: value.getAllExpenseList()[index].amount,
                      dateTime: value.getAllExpenseList()[index].dateTime)),
            ],
          )),
    );
  }
}
