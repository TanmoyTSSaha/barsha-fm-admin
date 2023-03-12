import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

import 'package:get/get.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();
  // File? _pickedImage;

  String? imgUrl;

  File? _imageFile;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'your-bucket-url.appspot.com');

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 85,
    );

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        log('No image selected.');
      }
    });
  }

  Future<void> _uploadFile() async {
    try {
      // Create a unique filename for the image
      String fileName = Path.basename(_imageFile!.path);
      Reference firebaseStorageRef =
          _storage.ref().child('blog/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
      await uploadTask.whenComplete(() => log('File uploaded'));
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.85,
      width: Get.width * 0.5,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.green,
          titleSpacing: 40,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.white,
                size: 34,
              ),
            ),
            const SizedBox(width: 10)
          ],
          title: const Text(
            "Create Blog",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      child: Text('Select Image'),
                    ),
                    SizedBox(height: 20),
                    _imageFile == null
                        ? const Text('No image selected.', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)
                        : const Text('Image Selected. Now upload the image', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _imageFile == null ? null : _uploadFile,
                      child: Text('Upload Image'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  maxLines: 2,
                  controller: titleTextController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      labelText: "Enter Blog Title",
                      labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent, width: 2.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0)))),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 10,
                  controller: descTextController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      labelText: "Enter Blog Description",
                      labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent, width: 2.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0)))),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (imgUrl != null) {
                      await FirebaseFirestore.instance
                          .collection('blog')
                          .doc()
                          .set({
                        'image': imgUrl,
                        'title': titleTextController.text,
                        'description': descTextController.text,
                      });
                      Get.back();
                      log(imgUrl!);
                    }
                  },
                  child: const Text("Upload Blog"),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }

  // Future<void> _pickImage() async {
  //   Reference referenceRoot = FirebaseStorage.instance.ref();
  //   Reference referenceDirImage = referenceRoot.child('blog');

  //   final ImagePicker _picker = ImagePicker();
  //   XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     var tempImage = await image.readAsBytes();
  //     Uint8List? localImage;
  //     String? productImageUrlFileType;

  //     FilePickerResult? imageFile = await FilePicker.platform.pickFiles();
  //     if (imageFile != null) {
  //       Uint8List bytes = imageFile.files[0].bytes!;
  //       setState(() {
  //         localImage = bytes;
  //         productImageUrlFileType = imageFile.files.first.extension;
  //       });
  //     }

  //     setState(() async {
  //       imgUrl = await uploadImage(folderName: 'blog', fileBytes: localImage!, fileType: productImageUrlFileType!);
  //     });

  //     // setState(() async {
  //     //   Reference referenceImageToUpload = referenceDirImage.child(image.name);

  //     //   try {
  //     //     referenceImageToUpload.putFile(File(image.name));

  //     //     imgUrl = await referenceImageToUpload.getDownloadURL();

  //     //   } catch (e) {
  //     //     log(e.toString());
  //     //   }
  //     // });
  //   } else {
  //     log('No image has been selected!');
  //   }
  // }

//   Future<String?> uploadImage(
//       {required String folderName,
//       required Uint8List fileBytes,
//       required String fileType,
//       BuildContext? context}) async {
//     String? imgUrl;

//     final metadata = SettableMetadata(contentType: fileType);
//     try {
//       TaskSnapshot reference = await FirebaseStorage.instance
//           .ref()
//           .child('$folderName/${DateTime.now().toString()}')
//           .putData(fileBytes, metadata)
//           .whenComplete(() async {});
//       imgUrl = await reference.ref.getDownloadURL();
//     } catch (e) {
//       showDialog(
//           barrierDismissible: false,
//           context: context!,
//           builder: ((context) => AlertDialog(
//                 title: const Text("Updated "),
//                 actions: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         Navigator.pop(context);
//                       },
//                       child: const Text("OK"))
//                 ],
//               )));
//       log("error while uploadin image $e");
//     }

//     return imgUrl;
//   }

}



// Future<String> uploadImage() async {
//   final html.FileUploadInputElement input = html.FileUploadInputElement();
//   input.accept = 'image/*'; // limit file selection to images
//   input.click();

//   await input.onChange.first;

//   final file = input.files!.first;
//   final fileName = file.name;
//   final destination = 'images/$fileName';
//   final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
//   await ref.putBlob(file);
//   final url = await ref.getDownloadURL();
//   log(url.toString());
//   return url;
// }