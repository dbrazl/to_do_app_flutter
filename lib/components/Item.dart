import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  String title;
  bool done;
  Function remove;
  Function save;

  Item({this.title, this.done, this.remove, this.save});

  Item.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['done'] = this.done;
    return data;
  }

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  Future<bool> confirmDismiss(direction) {
    if (direction == DismissDirection.endToStart)
      return Future<bool>.value(true);

    return Future<bool>.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.title),
      child: CheckboxListTile(
        title: Text("${widget.title}"),
        value: widget.done,
        onChanged: (value) {
          setState(() {
            widget.done = !widget.done;
            widget.save();
          });
        },
      ),
      onDismissed: (direction) {
        widget.remove(widget.title);
      },
      confirmDismiss: confirmDismiss,
    );
  }
}
