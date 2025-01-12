import 'package:flutter/material.dart';
import 'package:nexamart_user/features/auth/screens/auth_screen.dart';

Future<void> showLoginAlert(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: Text('You need to log in. Do you want to go to the login page?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(context, MaterialPageRoute(builder:(context) => AuthScreen())); // Navigate to login page
            },
            child: Text('Go to Login'),
          ),
        ],
      );
    },
  );
}
