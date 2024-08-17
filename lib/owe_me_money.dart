import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:jc_split_bill_flutter/View/money_returned.dart';

import 'View/owe_record_page.dart';

class OweMeMoney extends StatefulWidget {
  const OweMeMoney({super.key});

  @override
  State<OweMeMoney> createState() => _OweMeMoneyState();
}

// Need to add this for tab Controller
class _OweMeMoneyState extends State<OweMeMoney>
    with SingleTickerProviderStateMixin {
  final bool pageSelection = true;

  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: const Text('Owe Money'),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: 'Owe Record'),
            Tab(text: 'Money Returned'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          // Call the scaffold
          OweRecordPage(),

          // Call the scaffold
          MoneyReturned(),
        ],
      ),
    );
  }
}
