import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MoneyReturned extends StatefulWidget {
  const MoneyReturned({super.key});

  @override
  State<MoneyReturned> createState() => _MoneyReturnedState();
}

class _MoneyReturnedState extends State<MoneyReturned> {
  var box = Hive.box('split_bill_hive_database');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: box.values
            .where((item) => Map<String, dynamic>.from(item)['returned'])
            .length,
        itemBuilder: (context, index) {
          // Filter items that have returned (true)
          final filteredItems = box.values
              .where((item) => Map<String, dynamic>.from(item)['returned'])
              .toList();

          // Reverse the filtered items list
          final reversedFilteredItems = filteredItems.reversed.toList();
          final data = Map<String, dynamic>.from(reversedFilteredItems[index]);

          // Get the key for the item
          final key = box.keyAt(
            box.values.toList().indexOf(filteredItems[index]),
          );

          return Dismissible(
            key: Key(key.toString()), // Unique key for each item
            direction: DismissDirection.endToStart, // Swipe direction
            onDismissed: (direction) async {
              // Delete the item from the Hive database
              await box.delete(key);
              // Trigger UI refresh after deletion
              setState(() {});
            },
            background: Container(
              color: Colors.redAccent, // Background color
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 10.0), // Reduced padding
              child: const Padding(
                padding: EdgeInsets.all(8.0), // Reduced padding inside
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.delete,
                        color: Colors.white, size: 20), // Smaller icon size
                    SizedBox(width: 10), // Spacing between icon and text
                    Text(
                      'Delete',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold), // Smaller text size
                    ),
                  ],
                ),
              ),
            ),
            child: Padding(
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
                          // Name with bold styling and slightly larger font size
                          Row(
                            children: [
                              Icon(Icons.person,
                                  size: 20,
                                  color: Colors.grey.shade600), // Larger icon
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  data['name'].toString().toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20, // Increased font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8), // Adjusted spacing

                          // Container for Amount with background color and padding
                          Row(
                            children: [
                              Icon(Icons.attach_money,
                                  size: 20,
                                  color: Colors.grey.shade600), // Larger icon
                              const SizedBox(width: 8),
                              Text(
                                'Amount: RM${data['amount']}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8), // Consistent spacing

                          // Container for Date with background color and padding
                          Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  size: 20,
                                  color: Colors.grey.shade600), // Larger icon
                              const SizedBox(width: 8),
                              Text(
                                'Date: ${data['recordedDate']}',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8), // Consistent spacing

                          // Container for Remarks with background color and padding
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.comment,
                                  size: 20,
                                  color: Colors.grey.shade600), // Larger icon
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Remarks: ${data['remarks']}',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black87),
                                  overflow:
                                      TextOverflow.ellipsis, // Handle long text
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
