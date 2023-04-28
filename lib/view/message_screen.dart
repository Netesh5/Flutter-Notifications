import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Message Screen"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              body,
              style: const TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
