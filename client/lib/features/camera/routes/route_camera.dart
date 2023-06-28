import 'package:flutter/material.dart';

import '../pages/page_camera_result.dart';

PageRouteBuilder camera2CameraResult(RouteSettings settings) {
  final dynamic arguments = settings.arguments;
  final String filePath = arguments.imagePath as String;

  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, __, ___) => CameraResultPage(fileImagePath: filePath),
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (_, animation, __, child) => SlideTransition(
      position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
      child: child,
    ),
  );
}
