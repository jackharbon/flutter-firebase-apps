import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  final Function(String)? callback;
  const TextInputWidget(this.callback);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    widget.callback!(controller.text);
    FocusScope.of(context).unfocus();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (text) => click(),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.message_outlined),
        labelText: 'Write your post',
        suffixIcon: IconButton(
          splashColor: Colors.amber[900],
          color: Colors.amber,
          hoverColor: Colors.orange,
          tooltip: 'Publish the post',
          onPressed: click,
          icon: const Icon(Icons.send),
        ),
      ),
    );
  }
}
