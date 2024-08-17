import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'View/controllers.dart';
import 'View/main_menu_buttons.dart';
import '/individual_meal_2.dart';

class IndividualMeal extends StatefulWidget {
  const IndividualMeal({super.key});

  @override
  State<IndividualMeal> createState() => _IndividualMealState();
}

class _IndividualMealState extends State<IndividualMeal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController peopleController = TextEditingController();

  TextEditingController taxController = TextEditingController();

  TextEditingController billController = TextEditingController();

  void _submitForm() {
    // Once there are no empty inputs go next page
    if (_formKey.currentState!.validate()) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => IndividualMeal2(
                  amountOfPeople: int.parse(peopleController.text),
                  taxRate: int.parse(
                    taxController.text,
                  ))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MainMenuButtons(
          text: "Continue",
          icon: Icons.next_plan_outlined,
          onPressed: () {
            FocusScope.of(context).unfocus();
            _submitForm();
          },
          color: Colors.orange.shade200),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const Text("Split Bill"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            GroupMealControllers(
              title: "Total People",
              icon: Icons.people,
              controller: peopleController,
              hintText: "Enter amount of people ...",
              isDecimal: false,
              color: Colors.blue.shade100,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the number of people';
                }
                return null;
              },
              readOnly: false,
            ),
            GroupMealControllers(
              title: "Tax Rate",
              icon: Icons.percent,
              controller: taxController,
              hintText: "Enter tax Rate (eg. 6%)",
              isDecimal: false,
              color: Colors.purple.shade100,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the total tax Rate';
                }
                return null;
              },
              readOnly: false,
            ),
          ],
        ),
      ),
    );
  }
}
