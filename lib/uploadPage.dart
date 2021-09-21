import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
class UploadScreen extends StatefulWidget {
  static const id = 'uploadScreen';
  final int index;
  final String imgPath;
  final String title;
  final String subtitle;

  UploadScreen(this.index, this.imgPath, this.title, this.subtitle);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final String tit = 'Uploading....';

  final String sub = 'Please wait a moment while we upload your files.';

  set option1Text(String option1Text) {}

  set uploadedImage(Object? uploadedImage) {}

  _startFilePicker() async {
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files!.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedImage = reader.result;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            option1Text = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.5,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.5,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: MaterialButton(
                color: Colors.yellowAccent,
                onPressed: () {
                  _startFilePicker();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(child: Text('Upload File')),
                ),
              ),
            )
          ],
        ));
  }
}
