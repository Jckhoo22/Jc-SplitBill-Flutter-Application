import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'View/main_menu_buttons.dart';

import 'View/controllers.dart';

class IndividualMeal2 extends StatefulWidget {
  const IndividualMeal2(
      {super.key, required this.amountOfPeople, required this.taxRate});

  final int amountOfPeople;

  final int taxRate;

  @override
  State<IndividualMeal2> createState() => _IndividualMeal2State();
}

class _IndividualMeal2State extends State<IndividualMeal2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // This one is to refresh
  bool calculated = true;

  // I need to create lists of Controllers
  late List<TextEditingController> controllers;

  late List<TextEditingController> calculatedControllers;

  final bool readOnly = false;

  List<Color> colors = [
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.orange.shade100,
    Colors.purple.shade100,
    Colors.red.shade100
  ];

  final List<IconData> icons = [
    (Icons.people_outline_outlined),
    (Icons.people_alt_outlined)
  ];

  final List<String> alphabet = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  // This is to generate the amount of controllers based on the amount of People
  @override
  void initState() {
    super.initState();
    controllers = List.generate(
        widget.amountOfPeople, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: calculated
            ? AppBar(
                backgroundColor: Colors.grey.shade300,
                title: const Text("Pax Calculation"),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      showDialogs();
                    },
                    icon: const Icon(Icons.question_mark_outlined),
                  ),
                ],
              )
            : AppBar(
                backgroundColor: Colors.grey.shade300,
                title: const Text("Pax Calculation"),
                centerTitle: true,
                automaticallyImplyLeading: false,
              ),
        body: calculated
            ? Column(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 5,),
                            for (int i = 0; i < controllers.length; i++)
                              GroupMealControllers(
                                title:
                                    "Total Bill for Person ${alphabet[i % alphabet.length]} ",
                                icon: icons[i % icons.length],
                                controller: controllers[i],
                                hintText:
                                    "Enter bill for Person ${alphabet[i % alphabet.length]} ... ",
                                isDecimal: true,
                                color: colors[i % colors.length],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the amount';
                                  }
                                  return null;
                                },
                                readOnly: false,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MainMenuButtons(
                      text: "Finalize",
                      icon: Icons.calculate,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          calculated = false;
                          // I pass all the current value into the new list of controllers
                          calculatedControllers =
                              calculateTotalBill(controllers);
                          setState(() {});
                        }
                      },
                      color: Colors.orange.shade100,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 5,),
                          for (int i = 0; i < calculatedControllers.length; i++)
                            GroupMealControllers(
                              title:
                                  "Bill After Tax for Person ${alphabet[i % alphabet.length]} ",
                              icon: icons[i % icons.length],
                              controller: calculatedControllers[i],
                              hintText: "",
                              isDecimal: true,
                              color: colors[i % colors.length],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the amount';
                                }
                                return null;
                              },
                              readOnly: true,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                        child: MainMenuButtons(
                          text: "Edit",
                          icon: Icons.edit,
                          onPressed: () {
                            calculated = true;
                            controllers =
                                reverseTotalBill(calculatedControllers);
                            setState(() {});
                          },
                          color: Colors.teal.shade100,
                        ),
                      ),
                      Expanded(
                        child: MainMenuButtons(
                          text: "Main Menu",
                          icon: Icons.exit_to_app,
                          onPressed: () {
                            // Pop the current Page
                            Navigator.pop(context);

                            // Pop again to go to main menu
                            Navigator.pop(context);
                          },
                          color: Colors.red.shade200,
                        ),
                      ),
                    ]),
                  ),
                ],
              ));
  }

  void showDialogs() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GiffyDialog.image(
          Image.asset(
            "assets/gif/thinking.gif",
            height: 200,
            fit: BoxFit.cover,
          ),
          title: const Text(
            'How it works',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Enter total bill amount for each person using A to Z to represent them',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  List<TextEditingController> calculateTotalBill(
      List<TextEditingController> controllers) {
    // Now I receive all the text editing
    for (int i = 0; i < controllers.length; i++) {
      double getCurrentAmount = double.parse(controllers[i].text);
      double totalCalculatedAmount =
          getCurrentAmount + (getCurrentAmount * widget.taxRate / 100);

      // Set the text to Rm (calculated Amount)
      controllers[i].text = "Rm ${totalCalculatedAmount.toStringAsFixed(2)}";
    }
    return controllers;
  }

  // This function is to reverse the bill
  List<TextEditingController> reverseTotalBill(
      List<TextEditingController> controllers) {
    // Reverse the calculation to get the original amount
    for (int i = 0; i < controllers.length; i++) {
      // Remove the 'Rm ' prefix and parse the amount
      double getCurrentAmount =
          double.parse(controllers[i].text.replaceFirst('Rm ', ''));

      // Reverse the tax calculation
      double originalAmount = getCurrentAmount / (1 + widget.taxRate / 100);

      // Set the text back to the original amount
      controllers[i].text = originalAmount.toStringAsFixed(2);
    }
    return controllers;
  }
}
