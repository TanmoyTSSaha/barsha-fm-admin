import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLiveShowPage extends StatefulWidget {
  const AddLiveShowPage({super.key});

  @override
  State<AddLiveShowPage> createState() => _AddLiveShowPageState();
}

class _AddLiveShowPageState extends State<AddLiveShowPage> {
   TextEditingController titleTextController = TextEditingController();
    TextEditingController descTextController = TextEditingController();
    TextEditingController showTimeController = TextEditingController();
    TextEditingController showHostController = TextEditingController();

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
            const SizedBox(
              width: 10,
            )
          ],
          title: const Text(
            "Create Live Show",
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
                TextFormField(
                  maxLines: 1,
                   controller: titleTextController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      labelText: "Enter Show Day",
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
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      radius: 90,
                      backgroundColor: const Color(0xffD9D9D9),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    CircleAvatar(
                      radius: 90,
                      backgroundColor: const Color(0xffD9D9D9),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  maxLines: 1,
                   controller: descTextController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      labelText: "Enter Show Title",
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
                  maxLines: 1,
                   controller: showTimeController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      labelText: "Enter Show Time ",
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
                SizedBox(height: 10,),
                TextFormField(
                  maxLines: 1,
                   controller: showHostController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                      labelText: "Enter Show Host Name ",
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
                  onPressed: ()async {
                   await FirebaseFirestore.instance.collection('live').doc().set({
                    'image':'https://pixabay.com/photos/tree-sunset-clouds-sky-silhouette-736885/',
                     'image1':'https://pixabay.com/photos/tree-sunset-clouds-sky-silhouette-736885/',
                      'title': titleTextController.text,
                      'description': descTextController.text,
                      'showTime':showTimeController,
                      'showHost':showHostController
                    });
                    Get.back();
                  },
                  child: const Text("Upload Show"),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
