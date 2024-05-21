// To parse this JSON data, do
//
//     final lessonDataModel = lessonDataModelFromJson(jsonString);

import 'dart:convert';

List<LessonDataModel> lessonDataModelFromJson(String str) =>
    List<LessonDataModel>.from(
        json.decode(str).map((x) => LessonDataModel.fromJson(x)));

String lessonDataModelToJson(List<LessonDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LessonDataModel {
  ImageData? image;
  YoutubeVideo? youtubeVideo;
  Link? link;
  Gdrive? gdrive;
  Threed? threed;
  Mcq? mcq;
  Fib? fib;
  Owa? tf;
  Owa? owa;

  LessonDataModel({
    this.image,
    this.youtubeVideo,
    this.link,
    this.gdrive,
    this.threed,
    this.mcq,
    this.fib,
    this.tf,
    this.owa,
  });

  factory LessonDataModel.fromJson(Map<String, dynamic> json) =>
      LessonDataModel(
        image: json["image"] == null ? null : ImageData.fromJson(json["image"]),
        youtubeVideo: json["YoutubeVideo"] == null
            ? null
            : YoutubeVideo.fromJson(json["YoutubeVideo"]),
        link: json["link"] == null ? null : Link.fromJson(json["link"]),
        gdrive: json["gdrive"] == null ? null : Gdrive.fromJson(json["gdrive"]),
        threed: json["threed"] == null ? null : Threed.fromJson(json["threed"]),
        mcq: json["mcq"] == null ? null : Mcq.fromJson(json["mcq"]),
        fib: json["fib"] == null ? null : Fib.fromJson(json["fib"]),
        tf: json["tf"] == null ? null : Owa.fromJson(json["tf"]),
        owa: json["owa"] == null ? null : Owa.fromJson(json["owa"]),
      );

  Map<String, dynamic> toJson() => {
        "image": image?.toJson(),
        "YoutubeVideo": youtubeVideo?.toJson(),
        "link": link?.toJson(),
        "gdrive": gdrive?.toJson(),
        "threed": threed?.toJson(),
        "mcq": mcq?.toJson(),
        "fib": fib?.toJson(),
        "tf": tf?.toJson(),
        "owa": owa?.toJson(),
      };
}

class Fib {
  String? question;
  String? answer;
  String? questionForm;
  String? answerIndex;

  Fib({
    this.question,
    this.answer,
    this.questionForm,
    this.answerIndex,
  });

  factory Fib.fromJson(Map<String, dynamic> json) => Fib(
        question: json["question"],
        answer: json["answer"],
        questionForm: json["question_form"],
        answerIndex: json["answer_index"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "question_form": questionForm,
        "answer_index": answerIndex,
      };
}

class Gdrive {
  String? name;
  String? embedUrl;
  String? thumbnail;
  String? type;
  String? url;

  Gdrive({
    this.name,
    this.embedUrl,
    this.thumbnail,
    this.type,
    this.url,
  });

  factory Gdrive.fromJson(Map<String, dynamic> json) => Gdrive(
        name: json["name"],
        embedUrl: json["embedUrl"],
        thumbnail: json["thumbnail"],
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "embedUrl": embedUrl,
        "thumbnail": thumbnail,
        "type": type,
        "url": url,
      };
}

class ImageData {
  String? imageUrl;

  ImageData({
    this.imageUrl,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl,
      };
}

class Link {
  String? src;

  Link({
    this.src,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
      };
}

class Mcq {
  List<String>? options;
  String? mcqType;
  String? question;
  String? answer;
  String? questionUrl;

  Mcq({
    this.options,
    this.mcqType,
    this.question,
    this.answer,
    this.questionUrl,
  });

  factory Mcq.fromJson(Map<String, dynamic> json) => Mcq(
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
        mcqType: json["mcq_type"],
        question: json["question"],
        answer: json["answer"],
        questionUrl: json["question_url"],
      );

  Map<String, dynamic> toJson() => {
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
        "mcq_type": mcqType,
        "question": question,
        "answer": answer,
        "question_url": questionUrl,
      };
}

class Owa {
  String? question;
  String? answer;
  String? questionUrl;
  List<String>? options;

  Owa({
    this.question,
    this.answer,
    this.questionUrl,
    this.options,
  });

  factory Owa.fromJson(Map<String, dynamic> json) => Owa(
        question: json["question"],
        answer: json["answer"],
        questionUrl: json["question_url"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "question_url": questionUrl,
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
      };
}

class Threed {
  String? name;
  String? id;
  String? category;
  int? modelid;
  String? url;
  List<String>? labels;

  Threed({
    this.name,
    this.id,
    this.category,
    this.modelid,
    this.url,
    this.labels,
  });

  factory Threed.fromJson(Map<String, dynamic> json) => Threed(
        name: json["name"],
        id: json["id"],
        category: json["category"],
        modelid: json["modelid"],
        url: json["url"],
        labels: json["labels"] == null
            ? []
            : List<String>.from(json["labels"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "category": category,
        "modelid": modelid,
        "url": url,
        "labels":
            labels == null ? [] : List<dynamic>.from(labels!.map((x) => x)),
      };
}

class YoutubeVideo {
  String? name;
  String? thumbnail;
  String? videoUrl;
  String? embedUrl;

  YoutubeVideo({
    this.name,
    this.thumbnail,
    this.videoUrl,
    this.embedUrl,
  });

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) => YoutubeVideo(
        name: json["name"],
        thumbnail: json["thumbnail"],
        videoUrl: json["video_url"],
        embedUrl: json["embed_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "thumbnail": thumbnail,
        "video_url": videoUrl,
        "embed_url": embedUrl,
      };
}
