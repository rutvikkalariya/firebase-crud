import 'package:flutter/material.dart';

import 'add_data.dart';
import 'listview_add.dart';

class AddDisplay extends StatefulWidget {
  const AddDisplay({super.key});

  @override
  State<AddDisplay> createState() => _AddDisplayState();
}

class _AddDisplayState extends State<AddDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => AddData())));
                },
                child: Text('Add')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ListviewDetails())));
                },
                child: Text('Display')),
          ],
        ),
      ),
    );
  }
}
