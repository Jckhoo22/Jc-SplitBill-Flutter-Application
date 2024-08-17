import 'package:flutter/material.dart';
import 'View/controllers.dart';
import 'View/main_menu_buttons.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:math';

class GroupMeal extends StatefulWidget {
  const GroupMeal({super.key});

  @override
  State<GroupMeal> createState() => _GroupMealState();
}

class _GroupMealState extends State<GroupMeal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController peopleController = TextEditingController();
  TextEditingController billController = TextEditingController();

  Random random = Random();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialogs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // I prefer it in the centre
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      // Reuse the class
      floatingActionButton: MainMenuButtons(
          text: "Calculate",
          icon: Icons.calculate,
          onPressed: () {
            _submitForm();
          },
          color: Colors.orange.shade200),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const Text("Group Meal"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            // People
            GroupMealControllers(
              title: "Total People",
              icon: Icons.people,
              controller: peopleController,
              hintText: "Enter number of people ...",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the number of people';
                }
                return null;
              },
              isDecimal: false,
              color: Colors.blue.shade100,
              readOnly: false,
            ),

            const SizedBox(
              height: 10,
            ),

            // Total Bill
            GroupMealControllers(
              title: "Total Bill (RM)",
              icon: Icons.attach_money,
              controller: billController,
              hintText: "Enter total bill amount ...",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the total bill amount';
                }
                return null;
              },
              isDecimal: true,
              color: Colors.green.shade100,
              readOnly: false,
            ),
          ],
        ),
      ),
    );
  }

  void showDialogs() {
    FocusScope.of(context).unfocus();

    List<String> gif = [
      "assets/gif/cashflow.gif",
      "assets/gif/coins.gif",
      "assets/gif/money.gif"
    ];

    // Amount of People
    int amountOfPeople = int.parse(peopleController.text);

    // Total Bill
    double totalBill = double.parse(billController.text);

    // Formula
    String perPax = (totalBill / amountOfPeople).toStringAsFixed(2);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GiffyDialog.image(
          Image.asset(
            gif[random.nextInt(gif.length)],
            height: 200,
            fit: BoxFit.cover,
          ),
          title: Text(
            'Rm$perPax / Pax',
            textAlign: TextAlign.center,
          ),
          // content: const Text(
          //   '',
          //   textAlign: TextAlign.center,
          // ),
          actions: [
            // TextButton(
            //   onPressed: () => Navigator.pop(context),
            //   child: const Text('CANCEL'),
            // ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
