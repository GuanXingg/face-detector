import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getModel(String assetPath) async {
  if (Platform.isAndroid) return 'flutter_assets/$assetPath';

  final Directory appDir = await getApplicationSupportDirectory();
  final String path = '${appDir.path}/$assetPath';
  await Directory(dirname(path)).create(recursive: true);

  final file = File(path);
  if (!await file.exists()) {
    final ByteData byteData = await rootBundle.load(assetPath);
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
  return file.path;
}
