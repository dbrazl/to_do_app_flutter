import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/Item.dart';
import '../components/Input.dart';

class Home extends StatefulWidget {
  List<Item> items = [];
  String teste = "Tarefas";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {
    load();
  }

  Future load() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((item) => Item.fromJson(item)).toList();

      List<Item> items = result.map((item) {
        Item toSave = Item(
            title: item.title, done: item.done, remove: removeItem, save: save);
        return toSave;
      }).toList();

      setState(() {
        widget.items = items;
      });
    }
  }

  void save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }

  void removeItem(String title) {
    setState(() {
      widget.items.removeWhere((element) => element.title == title);
      save();
    });
  }

  void addItem(value) {
    if (value.isEmpty) return;

    setState(() {
      widget.items
          .add(Item(title: value, done: false, remove: removeItem, save: save));
      save();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.teste),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext buildContext, int index) {
          return widget.items[index];
        },
      ),
      bottomSheet: Input(onSubmitInput: addItem),
    );
  }
}
