import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Function onSubmitInput;

  Input({this.onSubmitInput});

  var controller = TextEditingController();

  void onSubmit(value) {
    controller.clear();
    onSubmitInput(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: "Nova tarefa",
          labelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        onFieldSubmitted: onSubmit,
      ),
      color: Colors.black12,
      height: 50,
      padding: EdgeInsets.only(left: 20),
    );
  }
}
