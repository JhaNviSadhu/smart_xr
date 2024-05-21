// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:smart_xr/network/app_exception.dart';
import 'package:smart_xr/network/base_api_service.dart';
import 'package:smart_xr/network/env.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> postApi(String url, {dynamic data}) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Accept-Encoding": ''
    };

    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse('${env.baseurl}$url'),
              headers: headers, body: json.encode(data))
          .timeout(const Duration(seconds: 180));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      // SmartDialog.dismiss();
      throw RequestTimeOut('');
    } on TimeoutException {
      // SmartDialog.dismiss();
    }
    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 403:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      default:
        throw FetchDataException(
            'Error accoured while communicating with server ${response.statusCode}');
    }
  }
}
