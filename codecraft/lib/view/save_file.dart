import 'package:codecraft/controller/save_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:codecraft/main.dart';
import 'package:codecraft/functions.dart';

import '../globals.dart';

TextEditingController saveFileNameController = TextEditingController(text: '');
FocusNode saveFileNameFocusNode = FocusNode(
  canRequestFocus: true,
);
TextEditingController saveFilePathController = TextEditingController(text: '');
FocusNode saveFilePathFocusNode = FocusNode(
  canRequestFocus: true,
);
FocusNode keyboardListenerFocus = FocusNode(
  canRequestFocus: true,
  descendantsAreFocusable: true,
);
SaveController saveController = SaveController();

class SaveFileScreen extends StatelessWidget {
  SaveFileScreen({required String fileName, required String filePath}) {
    saveController.saveFileName.value = fileName;
    saveFileNameController = TextEditingController(text: saveController.saveFileName.value);
    if (saveController.saveFilePath.value == '') {
      saveController.saveFilePath.value = directory.path;
    } else {
      saveController.saveFilePath.value = filePath;
    }
    saveFilePathController = TextEditingController(text: saveController.saveFilePath.value);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: color.main,
        child: RawKeyboardListener(
          focusNode: keyboardListenerFocus,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Save File',
                style: TextStyle(
                  color: color.contrast.withOpacity(0.5),
                  fontFamily: fontFamily,
                  fontSize: edit.fontSize.value * 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_present,
                      size: 40,
                      color: color.contrast.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 60,
                      width: 400,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: saveFileNameController,
                        focusNode: saveFileNameFocusNode,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        autofocus: true,
                        cursorWidth: edit.editFontSize.value / 1.7,
                        cursorColor: color.contrast,
                        cursorHeight: 37,
                        style: TextStyle(
                          color: color.contrast,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: edit.fontSize.value * 2,
                        ),
                        decoration: null,
                        onSubmitted: (fileName) {
                          if (fileName != '') {
                            saveController.saveFileName.value = fileName;
                            saveFilePathFocusNode.requestFocus();
                          } else {
                            saveFileNameFocusNode.requestFocus();
                          }
                        },
                      ),
                      decoration: BoxDecoration(
                        color: color.main,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: (color.isDarkMode)
                                ? (Offset(5, 5))
                                : (Offset(-5, -5)),
                            color: color.extremeContrast
                                .withOpacity((color.isDarkMode) ? 0.5 : 1),
                            blurRadius: 10,
                          ),
                          BoxShadow(
                            offset: (color.isDarkMode)
                                ? (Offset(-5, -5))
                                : (Offset(5, 5)),
                            color: color.contrast.withOpacity(0.1),
                            blurRadius: 10,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: color.contrast.withOpacity(0.5),
                      ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 60,
                      width: 400,
                      alignment: Alignment.center,
                      child: TextField(
                        controller: saveFilePathController,
                        focusNode: saveFilePathFocusNode,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        autofocus: true,
                        cursorWidth: edit.editFontSize.value / 1.7,
                        cursorColor: color.contrast,
                        cursorHeight: 37,
                        style: TextStyle(
                          color: color.contrast,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: edit.fontSize.value * 0.8,
                        ),
                        decoration: null,
                        onSubmitted: (filePath) {
                          if (filePath != '') {
                            if (filePath[filePath.length - 1] != '/') {
                              filePath += '/';
                            }
                            saveController.saveFilePath.value = filePath;
                            saveNewFile();
                            Get.back();
                          } else {
                            saveFilePathFocusNode.requestFocus();
                          }
                        },
                      ),
                      decoration: BoxDecoration(
                        color: color.main,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: (color.isDarkMode)
                                ? (Offset(5, 5))
                                : (Offset(-5, -5)),
                            color: color.extremeContrast
                                .withOpacity((color.isDarkMode) ? 0.5 : 1),
                            blurRadius: 10,
                          ),
                          BoxShadow(
                            offset: (color.isDarkMode)
                                ? (Offset(-5, -5))
                                : (Offset(5, 5)),
                            color: color.contrast.withOpacity(0.1),
                            blurRadius: 10,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onKey: (keyEvent) {
            if (keyEvent.isKeyPressed(LogicalKeyboardKey.escape)) {
              saveFileNameController = TextEditingController(text: '');
              saveFilePathController = TextEditingController(text: '');
              Get.back();
            } else if ((keyEvent.isControlPressed)) {
              if (keyEvent.isKeyPressed(LogicalKeyboardKey.keyS)) {
                saveFileNameController = TextEditingController(text: '');
                saveFilePathController = TextEditingController(text: '');
                Get.back();
              }
            } else if (keyEvent.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
              saveFilePathFocusNode.unfocus();
              saveFileNameFocusNode.requestFocus();
            } else if (keyEvent.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
              saveFileNameFocusNode.unfocus();
              saveFilePathFocusNode.requestFocus();
            }
          },
        ),
      ),
    );
  }
}
