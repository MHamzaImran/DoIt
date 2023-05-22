import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/models/profile.dart';
import '../services/profile_service.dart';
import '../src/app.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileNameController = TextEditingController();
  final _profileEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var pickedImage;
  var name;
  var email;
  final _profile = Profile();
  final _profileService = ProfileService();
  var theme = [];
  List<Profile> _profileList = <Profile>[];

  saveProfile(var image, String name, String email) async {
    _profile.image = image;
    _profile.name = name;
    _profile.email = email;
    await _profileService.saveProfile(_profile);
  }

  readProfile() async {
    _profileList = <Profile>[];
    var profiles = await _profileService.readProfile();
    profiles.forEach((prof) {
      setState(() {
        var profileModel = Profile();
        profileModel.image = prof['image'];
        profileModel.name = prof['name'];
        profileModel.email = prof['email'];
        _profileList.add(profileModel);
        pickedImage = _profileList[0].image;
        name = _profileList[0].name;
        email = _profileList[0].email;
        _profileEmailController.text = email;
        _profileNameController.text = name;
      });
    });
  }

  deleteProfile() async {
    await _profileService.deleteProfile();
  }

  pickImage(ImageSource source) async {
    try {
      final photo = await ImagePicker().pickImage(source: source);
      if (photo == null) return;
      setState(() {
        pickedImage = photo.path;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> requestCameraPermission() async {
    final cameraStatus = await Permission.camera.status;
    if(cameraStatus == PermissionStatus.denied){
      final status = await Permission.camera.request();
    }
  }

  Future<void> requestStoragePermission() async {
    final storageStatus = await Permission.storage.status;
    if(storageStatus == PermissionStatus.denied) {
      final status = await Permission.storage.request();
    }
  }

  @override
  void initState() {
    super.initState();
    readProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Provider.of<ThemeChanger>(context, listen: false).kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Provider.of<ThemeChanger>(context, listen: false).kAppbarText,
        ),
        backgroundColor:
            Provider.of<ThemeChanger>(context, listen: false).kAppbarColor,
        title: Text(
          'Edit Profile',
          style: TextStyle(
              color: Provider.of<ThemeChanger>(context, listen: false)
                  .kAppbarText),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(110.0)),
                      border: Border.all(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kAppbarColor,
                        width: 5.0,
                      ),
                    ),
                    child: ClipOval(
                      child: pickedImage != null
                          ? Image.file(
                              File(pickedImage),
                              height: 180,
                              width: 180,
                              scale: 1,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'images/profile.jpg',
                              width: 180,
                              height: 180,
                            ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 200,
                                  color: Provider.of<ThemeChanger>(context,
                                          listen: false)
                                      .kBackgroundColor,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Choose Profile Image',
                                        style: TextStyle(
                                            color: Provider.of<ThemeChanger>(
                                                    context,
                                                    listen: false)
                                                .kTextColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton.icon(
                                            onPressed: () async{
                                              await requestCameraPermission();
                                              await pickImage(ImageSource.camera);
                                            },
                                            icon: Icon(
                                              Icons.camera,
                                              color: Provider.of<ThemeChanger>(
                                                      context,
                                                      listen: false)
                                                  .kTileText,
                                              size: 35,
                                            ),
                                            label: Text(
                                              'Camera',
                                              style: TextStyle(
                                                color:
                                                    Provider.of<ThemeChanger>(
                                                            context,
                                                            listen: false)
                                                        .kTileText,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          TextButton.icon(
                                              onPressed: () async {
                                                await requestStoragePermission();
                                                await pickImage(
                                                    ImageSource.gallery);
                                              },
                                              icon: Icon(
                                                Icons.image,
                                                color:
                                                    Provider.of<ThemeChanger>(
                                                            context,
                                                            listen: false)
                                                        .kTileText,
                                                size: 35,
                                              ),
                                              label: Text(
                                                'Gallery',
                                                style: TextStyle(
                                                  color:
                                                      Provider.of<ThemeChanger>(
                                                              context,
                                                              listen: false)
                                                          .kTileText,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kAppbarColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name cannot be Empty";
                  } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return 'Category Should be in Alphabets';
                  } else {
                    return null;
                  }
                },
                cursorColor: Provider.of<ThemeChanger>(context, listen: false)
                    .kFloatColor,
                style: TextStyle(
                    color: Provider.of<ThemeChanger>(context, listen: false)
                        .kTextColor),
                controller: _profileNameController,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                    labelStyle: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                    fillColor: Provider.of<ThemeChanger>(context, listen: false)
                        .kFloatColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTextColor),
                    ),
                    labelText: 'Name',
                    hintText: "Enter Your Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be Empty";
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Email Should be of Format example@email.com';
                  } else {
                    return null;
                  }
                },
                cursorColor: Provider.of<ThemeChanger>(context, listen: false)
                    .kFloatColor,
                style: TextStyle(
                    color: Provider.of<ThemeChanger>(context, listen: false)
                        .kTextColor),
                controller: _profileEmailController,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                    labelStyle: TextStyle(
                        color: Provider.of<ThemeChanger>(context, listen: false)
                            .kTextColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Provider.of<ThemeChanger>(context, listen: false)
                                  .kTextColor),
                    ),
                    labelText: 'Email',
                    hintText: "Enter Your Email Address"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Provider.of<ThemeChanger>(context, listen: false)
                        .kFloatColor),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    deleteProfile();
                    saveProfile(pickedImage, _profileNameController.text,
                        _profileEmailController.text);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  ' Save ',
                  style: TextStyle(
                      color: Provider.of<ThemeChanger>(context, listen: false)
                          .kFloatText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
