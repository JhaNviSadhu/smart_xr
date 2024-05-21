import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:native_ar_viewer/native_ar_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_xr/model/lesson_data_model.dart';
import 'package:smart_xr/network/network_service.dart';
import 'package:smart_xr/network/rest_apis.dart';
import 'package:smart_xr/utils/app_common.dart';
import 'package:url_launcher/url_launcher.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  // List<LessonDataModel> lessonDataModel = <LessonDataModel>[];
  ImageData imageData = ImageData();
  YoutubeVideo youtubeVideo = YoutubeVideo();
  Link link = Link();
  Gdrive gDrive = Gdrive();
  List<Threed> threed = <Threed>[];
  Mcq mcq = Mcq();
  Fib fib = Fib();
  Owa tf = Owa();
  Owa owa = Owa();

  int selectedMCQANS = -1;

  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  String iosAssetPath = '';
  String taskId = '';
  String documentDirectoryPath = "";
  final String modelURL = io.Platform.isAndroid
      ? "https://firebasestorage.googleapis.com/v0/b/livvinyl-health-connector.appspot.com/o/catcow.glb?alt=media&token=da87cd4d-c9c1-4176-b1b3-a0b6fdc8734b"
      : "https://firebasestorage.googleapis.com/v0/b/livvinyl-health-connector.appspot.com/o/Astronaut.usdz?alt=media&token=833344f6-7f17-4f21-aa5c-6f9fc5313928";

  downloadAssetsForIOS() async {
    await _prepareSaveDir();
    taskId = (await FlutterDownloader.enqueue(
        url: modelURL, savedDir: documentDirectoryPath))!;
    print('taskId = $taskId');
  }

  launchAR(context) async {
    if (io.Platform.isAndroid) {
      await NativeArViewer.launchAR(modelURL);
    } else if (io.Platform.isIOS) {
      /// Here File name is hardcoded, in realtime application you will use your own logic to locate USDZ file.
      await NativeArViewer.launchAR("$documentDirectoryPath/Astronaut.usdz");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Platform not supported')));
    }
  }

  Future<void> _prepareSaveDir() async {
    documentDirectoryPath = (await _findLocalPath())!;
    final savedDir = io.Directory(documentDirectoryPath);
    bool hasExisted = await savedDir.exists();
    // if (!hasExisted) {
    savedDir.create();
    // }
  }

  Future<String?> _findLocalPath() async =>
      (await getApplicationDocumentsDirectory()).path;

  onScrollController() {
    scrollController.addListener(() {
      //scroll listener
      double showoffset =
          10.0; //Back to top botton will show on scroll offset 10.0

      if (scrollController.offset > showoffset) {
        emit(ShowButton());
      } else {
        emit(HideButton());
      }
    });
  }

  onLaunchUrl(dataUrl) async {
    final Uri url = Uri.parse(dataUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch');
    }
  }

  onANSSelecte(value) {
    selectedMCQANS = value;
    emit(RadioButtonChange());
  }

  onCheckAns(context) {
    if (textEditingController.text.isEmpty) {
      showResultDialog(context, title: "Error!", content: "Please write ans.",
          onDone: () {
        Navigator.pop(context);
      });
    } else {
      showResultDialog(context,
          title: textEditingController.text.trim().toLowerCase() ==
                  fib.answer?.toLowerCase()
              ? "Greate!"
              : "Keep learning",
          content: textEditingController.text.trim().toLowerCase() ==
                  fib.answer?.toLowerCase()
              ? "Your ans is correct 🎉"
              : "Your ans is wrong, the ans is ${fib.answer}", onDone: () {
        textEditingController.clear();
        Navigator.pop(context);
      });
    }
  }

  onCheckOWAAns(context) {
    if (textEditingController.text.isEmpty) {
      showResultDialog(context, title: "Error!", content: "Please write ans.",
          onDone: () {
        Navigator.pop(context);
      });
    } else {
      showResultDialog(context,
          title: textEditingController.text.trim().toLowerCase() ==
                  owa.answer?.toLowerCase()
              ? "Greate!"
              : "Keep learning",
          content: textEditingController.text.trim().toLowerCase() ==
                  owa.answer?.toLowerCase()
              ? "Your ans is correct 🎉"
              : "Your ans is wrong, the ans is ${owa.answer}", onDone: () {
        textEditingController.clear();
        Navigator.pop(context);
      });
    }
  }

  getData() {
    emit(HomeDataLoading());
    var data = {
      "lesson_id": 33,
    };

    try {
      NetworkApiServices()
          .postApi(APIPath.getLessonPlanData, data: data)
          .then((json) {
        List<LessonDataModel> modelLesson =
            lessonDataModelFromJson(jsonEncode(json));
        if (modelLesson.isNotEmpty) {
          imageData = modelLesson[0].image ?? ImageData();
          youtubeVideo = modelLesson[1].youtubeVideo ?? YoutubeVideo();
          link = modelLesson[2].link ?? Link();
          gDrive = modelLesson[3].gdrive ?? Gdrive();
          threed.add(modelLesson[4].threed ?? Threed());
          threed.add(modelLesson[5].threed ?? Threed());
          threed.add(modelLesson[6].threed ?? Threed());
          mcq = modelLesson[7].mcq ?? Mcq();
          fib = modelLesson[8].fib ?? Fib();
          tf = modelLesson[9].tf ?? Owa();
          owa = modelLesson[10].owa ?? Owa();
          Future.delayed(const Duration(seconds: 3), () {
            emit(HomeDataSuccess());
          });
        } else {
          emit(HomeDataError());
        }
        debugPrint("$modelLesson");
      });
    } catch (e) {
      debugPrint("$e");
      emit(HomeDataError());
    }
  }
}
