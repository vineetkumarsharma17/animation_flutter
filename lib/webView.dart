import 'dart:developer';
import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:webview_flutter_android/webview_flutter_android.dart'
    as webview_flutter_android;

class AddBranch extends StatefulWidget {
  const AddBranch({super.key});

  @override
  State<AddBranch> createState() => _AddBranchState();
}

class _AddBranchState extends State<AddBranch> {
  late final WebViewController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  WebViewController _webViewController = WebViewController();
  int agentId = 0;
  @override
  void initState() {
    super.initState();

    // String path =
    // 'https://testing.arthum.co.in/application/web/form/applyapp/1290';
    String path = 'https://erp.aus.ind.in/mobiapp/index.php';
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(path));

    if (Platform.isAndroid) {
      final myAndroidController = controller.platform
          as webview_flutter_android.AndroidWebViewController;

      myAndroidController.setOnShowFileSelector((params) async {
        // Control and show your picker
        // and return a list of Uris.
        log("file picker prm: ");
        log(params.acceptTypes.toString());
        log(params.filenameHint.toString());
        log(params.mode.name.toString());
        // log(params..toString());
        // File? file = await fileFromGallery();

        // if (file != null)
        //   return [Uri.file(file.path).toString()];
        // else
        return []; // Uris
      });
      // final controller = (_webViewController.platform as webview_flutter_android.AndroidWebViewController);
      // await controller.setOnShowFileSelector(_androidFilePicker);
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.currentUrl().then(
          (value) => log(value.toString()),
        );
    return Scaffold(
        appBar: AppBar(),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
