import 'package:flutter/material.dart';

import '../features/camera/routes/route_camera.dart';
import '../features/public/routes/route_home.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  String? path = settings.name;

  if (path == '/camera/results') return camera2CameraResult(settings);
  if (path == '/camera') return home2Camera(settings);

  return null;
}
