import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './features/public/pages/page_home.dart';
import './provider/provider_camera.dart';
import './routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider<CameraProvider>.value(
    value: CameraProvider()..setCameras(await availableCameras()),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'Face id',
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      );
}
