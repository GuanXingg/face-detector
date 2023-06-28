import 'package:flutter/material.dart';

import '../../camera/pages/page_camera.dart';

PageRouteBuilder home2Camera(RouteSettings settings) => PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => const CameraPage(),
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (_, animation, __, child) => SlideTransition(
        position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
        child: child,
      ),
    );
