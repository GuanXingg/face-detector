import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraProvider extends ChangeNotifier {
  List<CameraDescription> _cameras = [];

  List<CameraDescription> get cameras => _cameras;

  void setCameras(List<CameraDescription> newCameras) {
    _cameras = newCameras;
    notifyListeners();
  }

  void clearCameras() {
    _cameras.clear();
    notifyListeners();
  }
}
