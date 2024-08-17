import 'package:flutter/material.dart';
import 'View/main_menu_buttons.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Menu"),
        backgroundColor: Colors.grey.shade300,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Call Even Split Button
          const SizedBox(
            height: 20,
          ),
          // Call Individual Button
          MainMenuButtons(
            text: "Separate Meal",
            icon: Icons.person,
            onPressed: () {
              Navigator.pushNamed(context, '/individualMeal');
            },
            color: Colors.green.shade200,
          ),

          const SizedBox(
            height: 20,
          ),

          MainMenuButtons(
            text: "Group Meal",
            icon: Icons.people,
            onPressed: () {
              Navigator.pushNamed(context, '/groupMeal');
            },
            color: Colors.blue.shade100,
          ),

          const SizedBox(
            height: 20,
          ),

          MainMenuButtons(
            text: "Owe Money Record",
            icon: Icons.money_off,
            onPressed: () {
              Navigator.pushNamed(context, '/oweMeMoney');
            },
            color: Colors.red.shade100,
          ),
        ],
      ),
    );
  }
}
