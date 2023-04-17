import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "http://www.omdbapi.com/?apikey=50770fd4";

  static Uri _getUrl(String methodName) {
    print(_baseUrl + methodName);
    return Uri.parse(_baseUrl + methodName);
  }

  /// GET
  static Future<dynamic> get(String url,
      {Map<String, String>? headerMap}) async {
    dynamic responseJson;

    try {
      http.Response response;
      if (headerMap == null) {
        response = await http.get(_getUrl(url));
      } else {
        response = await http.get(_getUrl(url), headers: headerMap);
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
    return responseJson;
  }

  /// GET WITH QUERY PARAMETERS

  static Future<dynamic> getWithQueryParameters(
      String url, Map<String, dynamic> params,
      {Map<String, String>? headerMap}) async {
    dynamic responseJson;
    try {
      http.Response response;
      final uri = Uri.http("api.10cpu.cn", url, params);
      if (headerMap == null) {
        response = await http.get(uri);
      } else {
        response = await http.get(uri, headers: headerMap);
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
    return responseJson;
  }

  /// POST
  static Future<dynamic> post(String url,
      {Map<String, dynamic>? params, Map<String, String>? headerMap}) async {
    dynamic responseJson;
    String jsonToBeSent = json.encode(params);
    try {
      if (params == null) {
        throw "Parameters cannot be null";
      }
      http.Response response;
      if (headerMap == null) {
        response = await http.post(
          _getUrl(url),
          body: jsonToBeSent,
        );
      } else {
        response = await http.post(
          _getUrl(url),
          headers: headerMap,
          body: jsonToBeSent,
        );
      }

      responseJson = returnResponse(response);
    } on SocketException {
      throw "No Internet Connection";
    }
    return responseJson;
  }

  static dynamic returnResponse(http.Response response) {
    dynamic responseJson = jsonDecode(response.body);

    int statusCode = response.statusCode;
    if (responseJson["Response"].toString().toLowerCase() == "false") {
      throw responseJson["Error"];
    }
    switch (statusCode) {
      case 200:
        return responseJson;
      case 400:
        throw "Something went wrong";
      case 401:
        throw "Something went wrong";
      case 403:
        throw "Something went wrong";
      case 500:
        throw "Something went wrong";
      case 404:
        throw "Something went wrong";

      default:
        throw "Error occured while communication with server";
    }
  }
}
