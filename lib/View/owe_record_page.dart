import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:jc_split_bill_flutter/View/showdialog_controller.dart';

import '../Models/hive_crud.dart';
import '../Models/money_record.dart';

class OweRecordPage extends StatefulWidget {
  const OweRecordPage({super.key});

  @override
  State<OweRecordPage> createState() => _OweRecordPageState();
}

class _OweRecordPageState extends State<OweRecordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  TextEditingController remarkController = TextEditingController();

  var box = Hive.box('split_bill_hive_database');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 20), // Adjust margin for spacing
          width: MediaQuery.of(context).size.width *
              0.8, // Width as a percentage of the screen width
          child: FloatingActionButton.extended(
            elevation: 5,
            foregroundColor: Colors.black,
            backgroundColor: Colors.grey.shade300,
            label: const Text("Add"),
            icon: const Icon(Icons.add_box_outlined),
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onPressed: () {
              showDialogs();
            },
          ),
        ),
        body: ListView.builder(
          itemCount: box.values
              .where((item) => !Map<String, dynamic>.from(item)['returned'])
              .length,
          itemBuilder: (context, index) {
            // Filter items that haven't returned (false)
            final filteredItems = box.values
                .where((item) => !Map<String, dynamic>.from(item)['returned'])
                .toList();

            // Reverse the filtered items list
            final reversedFilteredItems = filteredItems.reversed.toList();
            final data =
                Map<String, dynamic>.from(reversedFilteredItems[index]);

            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Card(
                color: Colors.grey.shade200,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0), // Left padding
                            child: Text(
                              data['name'].toString().toUpperCase(),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0), // Left padding
                            child: Text(
                              'Amount : RM${data['amount']}',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0), // Left padding
                            child: Text(
                              'Date : ${data['recordedDate']}',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5.0), // Left padding
                            child: Text(
                              'Remarks : ${data['remarks']}',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      )),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 24.0),
                                content: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.orange,
                                      size: 48,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Confirm to delete Record ?',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Dismiss the dialog
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 16),
                                    ),
                                    onPressed: () async {
                                      // Get the key for the item to delete
                                      final key = box.keyAt(
                                        box.values
                                            .toList()
                                            .indexOf(filteredItems[index]),
                                      );
                                      await box.delete(key);
                                      // Trigger UI refresh after deletion

                                      Navigator.pop(context);

                                      setState(() {});
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 24.0),
                                content: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.orange,
                                      size: 48,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Confirm that person has returned the money?',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Dismiss the dialog
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 16),
                                    ),
                                    onPressed: () async {
                                      // Retrieve the key directly from the reversed filtered items list
                                      final data = Map<String, dynamic>.from(
                                          reversedFilteredItems[index]);
                                      final key = box.keys.firstWhere((k) =>
                                          Map<String, dynamic>.from(
                                                  box.get(k))['name'] ==
                                              data['name'] &&
                                          Map<String, dynamic>.from(
                                                  box.get(k))['amount'] ==
                                              data['amount'] &&
                                          Map<String, dynamic>.from(
                                                  box.get(k))['recordedDate'] ==
                                              data['recordedDate'] &&
                                          Map<String, dynamic>.from(
                                                  box.get(k))['remarks'] ==
                                              data['remarks']);

                                      // Retrieve the current data
                                      final currentData = box.get(key);

                                      // Update the data to set 'returned' to true
                                      if (currentData != null) {
                                        final updatedData =
                                            Map<String, dynamic>.from(
                                                currentData);
                                        updatedData['returned'] = true;

                                        // Save the updated data back to Hive
                                        await box.put(key, updatedData);

                                        // Trigger UI refresh after updating
                                        setState(() {});
                                      }

                                      Navigator.of(context)
                                          .pop(); // Dismiss the dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  void showDialogs() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GiffyDialog.image(
          Image.asset(
            "assets/gif/money.gif",
            height: 200,
            fit: BoxFit.cover,
          ),
          title: const Text(
            'Enter Record Details',
            textAlign: TextAlign.center,
          ),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShowDialogController(
                    controller: nameController,
                    labelText: "Name",
                    hintText: "Enter Name",
                    icon: const Icon(Icons.person),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: "Date",
                        hintText: "Select Date",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.date_range),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd MMMM yyyy').format(pickedDate);
                          dateController.text = formattedDate;
                        }
                      },
                      readOnly: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: amountController,
                      decoration: InputDecoration(
                        labelText: "Amount",
                        hintText: "Enter amount",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.attach_money),
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                        DecimalTextInputFormatter(decimalRange: 2),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  ShowDialogController(
                    controller: remarkController,
                    labelText: "Remarks",
                    hintText: "Enter Remarks",
                    icon: const Icon(Icons.notes),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Remark";
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Remove focus node (keyboard)
                FocusScope.of(context).requestFocus(FocusNode());

                if (_formKey.currentState!.validate()) {
                  // Handle saving the record or any other logic
                  var data = MoneyRecord(
                      name: nameController.text.toUpperCase(),
                      recordedDate: dateController.text,
                      amount: amountController.text,
                      remarks: remarkController.text,
                      returned: false);
                  HiveCrud.addMoneyRecord(data.toJson());

                  // Now refresh and remove all the inputs
                  nameController.clear();
                  dateController.clear();
                  amountController.clear();
                  remarkController.clear();

                  // Refresh the UI
                  setState(() {});

                  // Remove the dialog
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
