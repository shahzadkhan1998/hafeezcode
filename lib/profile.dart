import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userscreen/provider/allprovider.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
 final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

   File? imageFile;
     CroppedFile? _croppedFile;

     /// Get from gallery
  getFromGallery() async {
    var pickedFile = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    )) ;
    _cropImage(pickedFile!.path);
  }

  /// Crop Image
  _cropImage(filePath) async {
    var croppedImage = (await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    )) ;
    if (croppedImage != null) {
        _croppedFile = croppedImage;
      setState(() {});
    }
  }
  

  



  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileUpdaterProvider);
    return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
              onTap: (){
              getFromGallery();
              print(imageFile);
              print(_croppedFile!.path);
              },
                child:  CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.amber,
                
          
              child: _croppedFile == null ? Container() : Center(
                child: Image.file(File(_croppedFile!.path),
                ),
              ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _genderController,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if(_firstNameController.text.isNotEmpty && _lastNameController.text.isNotEmpty && _genderController.text.isNotEmpty)
                  {
                    ref.read(profileUpdaterProvider.notifier).updateData(_firstNameController.text.trim(), _lastNameController.text.trim(), _genderController.text.trim());
                  }
                 
                },
                child: const Text('Update Profile'),
              ),
            ],
          ),
        ),
    ),
    
    );
  }
}