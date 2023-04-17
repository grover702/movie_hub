import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/baseClass.dart';

class FilterBottomSheet with BaseClass {



 static void showFilterBottomSheet({
    required BuildContext context,
    required Function onNameClicked,
    required Function onYearClicked,
    required Function onCancelClicked,

  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Choose any of the below options to sort the movies',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              'Name',
              style: GoogleFonts.roboto(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            onPressed: () async {
              Get.back();
              onNameClicked();
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              'Year',
              style: GoogleFonts.roboto(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            onPressed: () async {
              Get.back();
              onYearClicked();
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            onCancelClicked();
          },
          child: Text(
            'Cancel',
            style: GoogleFonts.roboto(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
