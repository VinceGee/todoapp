import 'package:flutter/material.dart';

class TypeaheadNothingFound extends StatefulWidget {
  final String message;
  const TypeaheadNothingFound({Key? key, required this.message}) : super(key: key);

  @override
  State<TypeaheadNothingFound> createState() => _TypeaheadNothingFoundState();
}

class _TypeaheadNothingFoundState extends State<TypeaheadNothingFound> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Center(
        child: ListTile(
          title: Text(
            widget.message,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
