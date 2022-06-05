import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/Screens/homescreen.dart';
import 'package:intl/intl.dart';

class AddNote extends StatelessWidget {
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('notes');
  final dateCreated = DateFormat.yMEd().add_jms().format(DateTime.now());
  final timeCreated = Timestamp.fromDate(DateTime.now());

  AddNote({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            color: Color.fromARGB(255, 53, 53, 53),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  AddNoteBar(
                      ref: ref,
                      title: title,
                      content: content,
                      dateCreated: dateCreated,
                      timeCreated: timeCreated),
                  TextField(
                    controller: title,
                    decoration: const InputDecoration(
                        hintText: 'Title',
                        hintStyle:
                            TextStyle(color: Color(0xff929292), fontSize: 20),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff929292)))),
                    maxLines: null,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: content,
                      maxLines: null,
                      expands: true,
                      readOnly: false,
                      decoration: const InputDecoration(
                        hintText: 'Content...',
                        hintStyle:
                            TextStyle(color: Color(0xff929292), fontSize: 25),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class AddNoteBar extends StatelessWidget {
  const AddNoteBar({
    Key? key,
    required this.ref,
    required this.title,
    required this.content,
    required this.dateCreated,
    required this.timeCreated,
  }) : super(key: key);

  final CollectionReference<Object?> ref;
  final TextEditingController title;
  final TextEditingController content;
  final String dateCreated;
  final Timestamp timeCreated;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ref.add({
                'title': title.text,
                'content': content.text,
                'date': dateCreated,
                'time': timeCreated,
              }).whenComplete(() => Navigator.pop(context));
            },
            child: Container(
              height: 35,
              width: 100,
              decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Center(
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
