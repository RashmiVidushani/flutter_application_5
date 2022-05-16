import 'dart:io';

import 'package:camera/camera.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_5/Constants/firestore_constants.dart';
import 'package:flutter_application_5/Modals/chat_user.dart';
import 'package:flutter_application_5/Providers/profile_provider.dart';
import 'package:flutter_application_5/Screens/homescreen.dart';
import 'package:flutter_application_5/widgets/loading_view.dart';
import 'package:flutter_application_5/widgets/text_field_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? displayNameController;
  TextEditingController? aboutMeController;
  final TextEditingController _phoneController = TextEditingController();

  late String currentUserId;
  String dialCodeDigits = '+00';
  String id = '';
  String displayName = '';
  String photoUrl = '';
  String phoneNumber = '';
  String aboutMe = '';
  bool isLoading = false;
  File? avatarImageFile;
  late ProfileProvider profileProvider;
  final FocusNode focusNodeNickname = FocusNode();

  void readLocal() {
    setState(() {
      id = profileProvider.getPrefs(FirestoreConstants.id) ?? "";
      displayName =
          profileProvider.getPrefs(FirestoreConstants.displayName) ?? "";

      photoUrl = profileProvider.getPrefs(FirestoreConstants.photoUrl) ?? "";
      phoneNumber =
          profileProvider.getPrefs(FirestoreConstants.phoneNumber) ?? "";
      aboutMe = profileProvider.getPrefs(FirestoreConstants.aboutMe) ?? "";
    });
    displayNameController = TextEditingController(text: displayName);
    aboutMeController = TextEditingController(text: aboutMe);
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    // PickedFile is not supported
    // Now use XFile?
    XFile? pickedFile = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
    });
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if (image != null) {
      setState(() {
        avatarImageFile = image;
        isLoading = true;
      });
      uploadFile();
    }
  }

  Future uploadFile() async {
    String fileName = id;
    UploadTask uploadTask =
        profileProvider.uploadImageFile(avatarImageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      photoUrl = await snapshot.ref.getDownloadURL();
      ChatUser updateInfo = ChatUser(
          id: id,
          photoUrl: photoUrl,
          displayName: displayName,
          phoneNumber: phoneNumber,
          aboutMe: aboutMe);
      profileProvider
          .updateFirestoreData(
              FirestoreConstants.pathUserCollection, id, updateInfo.toJson())
          .then((value) async {
        await profileProvider.setPrefs(FirestoreConstants.photoUrl, photoUrl);
        setState(() {
          isLoading = false;
        });
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void updateFirestoreData() {
    focusNodeNickname.unfocus();
    setState(() {
      isLoading = true;
      if (dialCodeDigits != "+00" && _phoneController.text != "") {
        phoneNumber = dialCodeDigits + _phoneController.text.toString();
      }
    });
    ChatUser updateInfo = ChatUser(
        id: id,
        photoUrl: photoUrl,
        displayName: displayName,
        phoneNumber: phoneNumber,
        aboutMe: aboutMe);
    profileProvider
        .updateFirestoreData(
            FirestoreConstants.pathUserCollection, id, updateInfo.toJson())
        .then((value) async {
      await profileProvider.setPrefs(
          FirestoreConstants.displayName, displayName);
      await profileProvider.setPrefs(
          FirestoreConstants.phoneNumber, phoneNumber);
      await profileProvider.setPrefs(
        FirestoreConstants.photoUrl,
        photoUrl,
      );
      await profileProvider.setPrefs(FirestoreConstants.aboutMe, aboutMe);

      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'Update Successful');
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    }).catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    profileProvider = context.read<ProfileProvider>();
    readLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: getImage,
                  child: Container(
                    alignment: Alignment.center,
                    child: avatarImageFile == null
                        ? photoUrl.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.network(
                                  photoUrl,
                                  fit: BoxFit.cover,
                                  width: 120,
                                  height: 120,
                                  errorBuilder: (context, object, stackTrace) {
                                    return const Icon(
                                      Icons.account_circle,
                                      size: 90,
                                      color: Colors.blueGrey,
                                    );
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.grey,
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const Icon(
                                Icons.account_circle,
                                size: 90,
                                color: Colors.blueGrey,
                              )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.file(
                              avatarImageFile!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                    margin: const EdgeInsets.all(20),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Enter Name ",
                      ),
                      /*kTextInputDecoration.copyWith(
                          hintText: 'Write your Name'),*/
                      controller: displayNameController,
                      onChanged: (value) {
                        displayName = value;
                      },
                      focusNode: focusNodeNickname,
                    ),
                    vertical15,
                    const Text(
                      'About Me...',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Say something about you ",
                      ),
                      onChanged: (value) {
                        aboutMe = value;
                      },
                    ),
                    vertical15,
                    const Text(
                      'Select Country Code',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.teal, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CountryCodePicker(
                        onChanged: (country) {
                          setState(() {
                            dialCodeDigits = country.dialCode!;
                          });
                        },
                        initialSelection: 'IN',
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        favorite: const ["+1", "US", "+91", "IN"],
                      ),
                    ),
                    vertical15,
                    const Text(
                      'Phone Number',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Phone Number",
                        prefix: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            dialCodeDigits,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      controller: _phoneController,
                      maxLength: 12,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: updateFirestoreData,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Update Info'),
                    )),
              ],
            ),
          ),
          Positioned(
              child: isLoading ? const LoadingView() : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
