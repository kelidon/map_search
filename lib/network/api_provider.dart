import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiProvider {
  static final ApiProvider _provider = ApiProvider._internal();

  factory ApiProvider() {
    return _provider;
  }

  ApiProvider._internal();

  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return _response(response);
    } on SocketException {
      throw Exception("No internet connection");
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        try {
          return json.decode(response.body.toString());
        } on FormatException {
          return response.body.toString();
        }
      default:
        throw Exception(
            "Failed with status code " + response.statusCode.toString());
    }
  }
}
