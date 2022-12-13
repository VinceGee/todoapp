import 'package:todoapp/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DialogConfirmation extends StatefulWidget {
  final String title;
  final String message;
  const DialogConfirmation({Key? key, required this.title, required this.message}) : super(key: key);

  @override
  State<DialogConfirmation> createState() => _DialogConfirmationState();
}

class _DialogConfirmationState extends State<DialogConfirmation> {


  @override
  Widget build(BuildContext context) {
    Widget continueButton = TextButton(
        onPressed: () {
            Navigator.pop(context);
          },
        child: const Text('OK', style: TextStyle(color: AppColors.primary))
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(widget.title, style: const TextStyle(fontSize: 18),),
      content: Text(widget.message, style: const TextStyle(fontSize: 14)),
      actions: [
        continueButton,
      ],
    );

    return alert;

  }
}