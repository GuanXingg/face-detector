// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:face_id/features/camera/pages/page_camera_result.dart';
import 'package:face_id/provider/provider_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:provider/provider.dart';

import '../functions/camera/get_object_model.dart';
import '../functions/camera/input_camera_image.dart';
import '../painter/camera/object_detector_painter.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late final CameraController _cameraController;
  late final ObjectDetector _objectDetector;

  bool _canProcess = false;
  bool _isBusy = false;
  CustomPaint? _customPaint;

  void _initObjectDetector() async {
    const String path = 'assets/models/object_labeler.tflite';
    final String modelPath = await getModel(path);
    _objectDetector = ObjectDetector(
      options: LocalObjectDetectorOptions(
        mode: DetectionMode.stream,
        modelPath: modelPath,
        classifyObjects: true,
        multipleObjects: false,
      ),
    );

    _canProcess = true;
  }

  void _initCamera() async {
    final List<CameraDescription> cameras = Provider.of<CameraProvider>(context, listen: false).cameras;
    _cameraController = CameraController(
      cameras[1],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid ? ImageFormatGroup.nv21 : ImageFormatGroup.bgra8888,
    );

    await _cameraController.initialize();
    if (!mounted) return;

    await _cameraController.startImageStream((CameraImage image) {
      final InputImage? inputImage = inputCameraImage(cameras[1], image);
      if (inputImage == null) return;

      processImage(inputImage);
    });

    setState(() {});
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    final List<DetectedObject> objects = await _objectDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
      final painter = ObjectDetectorPainter(objects, inputImage.metadata!.rotation, inputImage.metadata!.size);
      _customPaint = CustomPaint(painter: painter);
    }

    if (objects.isNotEmpty) {
      final DetectedObject object = objects.first;
      final List<Label> labels = object.labels;

      if (labels.isNotEmpty) {
        final Label label = labels.first;
        final String objectName = label.text;

        if (objectName == 'Person') await handleTakePicture();
      }
    }

    _isBusy = false;
    if (!mounted) return;
    setState(() {});
  }

  Future<void> handleTakePicture() async {
    await _cameraController.stopImageStream();
    final XFile file = await _cameraController.takePicture();
    final String filePath = file.path;

    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => CameraResultPage(fileImagePath: filePath)));
      },
    );
  }

  @override
  void initState() {
    _initObjectDetector();
    _initCamera();
    super.initState();
  }

  @override
  void dispose() {
    _objectDetector.close();
    _cameraController.stopImageStream();
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) return const Scaffold(body: SpinKitDoubleBounce(color: Colors.orange));

    return Scaffold(
      appBar: AppBar(),
      body: Stack(fit: StackFit.expand, children: [
        CameraPreview(_cameraController),
        if (_customPaint != null) _customPaint!,
      ]),
    );
  }
}
