import 'package:flutter/material.dart';
import 'package:jc_split_bill_flutter/Models/money_record.dart';
import 'package:jc_split_bill_flutter/Models/money_record.g.dart';
import 'package:jc_split_bill_flutter/owe_me_money.dart';
import 'package:jc_split_bill_flutter/splashscreen.dart';
import '/group_meal.dart';
import '/individual_meal.dart';
import '/main_menu.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(MoneyRecordAdapter());

  // Open a box
  box = await Hive.openBox('split_bill_hive_database');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
      routes: {
        '/groupMeal': (context) => const GroupMeal(),
        '/individualMeal': (context) => const IndividualMeal(),
        '/oweMeMoney': (context) => const OweMeMoney(),
      },
    );
  }
}
