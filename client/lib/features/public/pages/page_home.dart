import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/camera'),
            style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.all(15))),
            icon: const Icon(Icons.camera_alt),
            label: const Text('Check attendance'),
          ),
        ),
      );
}
