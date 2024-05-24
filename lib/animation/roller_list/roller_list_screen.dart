import 'package:flutter/material.dart';

import 'date_selector.dart';
import 'slot_machine.dart';
import 'time_selector.dart';

class RollerListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RollerListScreenState();
  }
}

class _RollerListScreenState extends State<RollerListScreen> {
  int selectedItem = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RollerList"),
        actions: <Widget>[],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: SlotMachine()),
      ),
    );
  }
}
