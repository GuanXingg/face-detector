import 'dart:io';

import 'package:flutter/material.dart';

class CameraResultPage extends StatelessWidget {
  final String fileImagePath;

  const CameraResultPage({super.key, required this.fileImagePath});

  @override
  Widget build(BuildContext context) {
    File picture = File(fileImagePath);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(child: Image.file(picture)),
    );
  }
}
