import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class ImageUploader extends StatefulWidget {
  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  File? _imageFile;
  Uint8List? _imageData;
  String? imgUrl;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'your-bucket-url.appspot.com');

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(
      source: source,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 85,
    );

    setState(() async {
      if (pickedFile != null) {
        _imageData = await pickedFile.readAsBytes();
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadFile() async {
    try {
      // Create a unique filename for the image
      String fileName = Path.basename(_imageFile!.path);
      Reference firebaseStorageRef =
          _storage.ref().child('images/$fileName');
      
      UploadTask uploadTask = firebaseStorageRef.putData(_imageData!);
      await uploadTask.whenComplete(() => print('File uploaded'));
    
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _pickImage(ImageSource.gallery),
          child: Text('Select Image'),
        ),
        SizedBox(height: 20),
        _imageFile == null
            ? Text('No image selected.')
            : Image.file(_imageFile!),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _imageFile == null ? null : _uploadFile,
          child: Text('Upload Image'),
        ),
      ],
    );
 
  }
}
