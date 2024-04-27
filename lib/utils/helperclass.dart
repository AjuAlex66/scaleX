import 'dart:developer';

import 'package:bookapp/main.dart';
import 'package:bookapp/utils/changerclass.dart';
import 'package:bookapp/utils/initializerclass.dart';
import 'package:bookapp/utils/prefmanager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Helper {
  static GlobalKey key = NavigationService.navigatorKey;
  static final context = key.currentContext;
  static final height = MediaQuery.of(context!).size.height;
  static final width = MediaQuery.of(context!).size.width;
  static allowHeight(double? height) => SizedBox(height: height ?? 10);
  static allowWidth(double? width) => SizedBox(width: width ?? 10);
  static showLog(String? message) => log(message!);
  // static setDateFormat({String? format, DateTime? dateTime}) =>
  //     DateFormat(format ?? "yyyy-MM-dd").format(dateTime ?? DateTime.now());
  static shrink() => const SizedBox.shrink();

  static showWaiting() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Helper.allowHeight(Helper.height / 12),
          const CupertinoActivityIndicator(),
          Helper.allowHeight(10),
          const Text("Please wait...", textAlign: TextAlign.center),
        ],
      );

  static Future<void> showInfo() async {
    Initializer.memory = await PrefManager.getMemory();
    if (!Initializer.memory!) {
      await Future.delayed(const Duration(milliseconds: 600), () {
        showModalBottomSheet(
          context: key.currentContext!,
          builder: (context) => Container(
            padding:
                const EdgeInsets.only(top: 30, bottom: 20, left: 15, right: 15),
            width: Helper.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "The status button state changes when tapped, but it's not preserved because there's no API call or status change happening. Therefore, the button state resets to 'Read' state on app restarts, API calls, and searches.",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Helper.allowHeight(10),
                Row(
                  children: [
                    Consumer<Changer>(
                      builder: (context, value, child) => Checkbox(
                        value: Initializer.checkBox,
                        onChanged: (value) {
                          Initializer.checkBox = value;
                          context.read<Changer>().justChange();
                        },
                      ),
                    ),
                    Helper.allowWidth(10),
                    const Text("Don't show again")
                  ],
                ),
                Helper.allowHeight(10),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Colors.green,
                  minWidth: Helper.width,
                  onPressed: () async {
                    Helper.pop();
                    await PrefManager.setMemory(Initializer.checkBox!);
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    }
  }

  static void pop() => Navigator.pop(key.currentContext!);
  // static dHeight(double? value) => height / value!;
  //  static dWidth(double? value) => width / value!;
}
