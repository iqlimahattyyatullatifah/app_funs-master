import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:funs_app/pages/home.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';

class Detect extends StatefulWidget {
  const Detect({super.key});

  @override
  State<Detect> createState() => _DetectState();
}

class _DetectState extends State<Detect> {
  ScreenshotController _screenshotController = ScreenshotController();

  final textRecognizer = TextRecognizer();

  void _captureAndChooseImage() async {
    try {
      await _screenshotController.capture().then((Uint8List? image) async {
        final name = 'ESP32CAM-${DateTime.now()}';
        ImageGallerySaver.saveImage(image!, name: name);
      });
      await CircularProgressIndicator();
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      final inputImage = InputImage.fromFilePath(pickedImage!.path);
      final recognizedText = await textRecognizer.processImage(inputImage);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomePage(sourceText: recognizedText.text),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Coba kembali'),
        ),
      );
    }
  }

  Future<void> saveToGallery() async {
    var file;
    try {
      await _screenshotController.capture().then((Uint8List? image) async {
        var imagePath = image as XFile;
        final file = File(imagePath.path);

        //RECOGNIZED
        final inputImage = InputImage.fromFile(file);
        final recognizedText = await textRecognizer.processImage(inputImage);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(sourceText: recognizedText.text),
        ));
        print(recognizedText.text);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }

    // _screenshotController.capture().then((image) async {
    //   await ImageGallerySaver.saveImage(image!, name: 'dsdsd');
    // });
  }

  VlcPlayerController _vlcViewController = new VlcPlayerController.network(
      // "http://192.168.1.9/:81/stream",

      "http://192.168.43.183:81/stream",
      // 'https://media.w3.org/2010/05/sintel/trailer.mp4',
      autoPlay: true,
      hwAcc: HwAcc.full,
      options: VlcPlayerOptions());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Screenshot(
            controller: _screenshotController,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: VlcPlayer(
                controller: _vlcViewController,
                aspectRatio: 16 / 9,
                placeholder: Center(
                    child: SizedBox(
                        height: 70,
                        width: 70,
                        child: CircularProgressIndicator())),
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          InkWell(
            onTap: () {
              _captureAndChooseImage();
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Colors.blue.shade100, Colors.blue],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
              ),
              child: Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}
