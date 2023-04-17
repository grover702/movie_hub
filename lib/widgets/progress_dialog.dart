import 'package:flutter/material.dart';


class ProgressDialog extends StatelessWidget {
  const ProgressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation:  5,
        color: Colors.black,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.yellow,
            ),
          ),
        ),
      ),
    );
  }
}
