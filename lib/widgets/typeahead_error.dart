import 'package:todoapp/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TypeaheadError extends StatefulWidget {
  final String message;
  const TypeaheadError({Key? key, required this.message}) : super(key: key);

  @override
  State<TypeaheadError> createState() => _TypeaheadErrorState();
}

class _TypeaheadErrorState extends State<TypeaheadError> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Center(
        child: Text(
            widget.message,
            style: TextStyle(
                color: Theme.of(context).errorColor
            )
        ),
      ),
    );
  }
}
