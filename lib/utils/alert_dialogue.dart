import 'package:flutter/material.dart';

Future<void> showAlertDialogue(
    {required BuildContext context,
    required String title,
    required String body}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      alignment: Alignment.center,
      actions: [
        TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Okay'))
      ],
    ),
  );
}
