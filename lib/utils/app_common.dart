import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_xr/utils/app_textstyle.dart';

extension EmptySizedBox on num {
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

enum ContentType {
  imageView,
  youtubeVideoView,
  openLink,
  documentView,
  threedView,
  mcqView,
  fibView,
  tfView,
  owaView
}

showResultDialog(context, {title, content, onDone}) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        "$title", // textEditingController.text.trim() == fib.answer
        //     ? "Greate!"
        //     : "Keep learning",
        style: AppTextStyle.callout(),
      ),
      content: Text(
        "$content",
        style: AppTextStyle.callout(fontWeight: FontWeight.w400),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: onDone ?? () {},
          isDefaultAction: true,
          textStyle: AppTextStyle.callout14(),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}
