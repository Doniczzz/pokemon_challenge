import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';

enum ApiCallType {
  GET,
  POST,
  DELETE,
  PUT,
  PATCH,
}

enum BodyType {
  NONE,
  JSON,
  TEXT,
  X_WWW_FORM_URL_ENCODED,
  MULTIPART,
}

class ApiCallRecord extends Equatable {
  ApiCallRecord(this.callName, this.apiUrl, this.headers, this.params,
      this.body, this.bodyType);
  final String callName;
  final String apiUrl;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> params;
  final String? body;
  final BodyType? bodyType;

  @override
  List<Object?> get props =>
      [callName, apiUrl, headers, params, body, bodyType];
}

class ApiCallResponse {
  const ApiCallResponse(
    this.jsonBody,
    this.headers,
    this.statusCode, {
    this.response,
  });
  final dynamic jsonBody;
  final Map<String, String> headers;
  final int statusCode;
  final http.Response? response;
  // Whether we received a 2xx status (which generally marks success).
  bool get succeeded => statusCode >= 200 && statusCode < 300;
  String getHeader(String headerName) => headers[headerName] ?? '';
  // Return the raw body from the response, or if this came from a cloud call
  // and the body is not a string, then the json encoded body.
  String get bodyText =>
      response?.body ??
      (jsonBody is String ? jsonBody as String : jsonEncode(jsonBody));

  static ApiCallResponse fromHttpResponse(
    http.Response response,
    bool returnBody,
  ) {
    var jsonBody;
    try {
      final responseBody = returnBody
          ? const Utf8Decoder().convert(response.bodyBytes)
          : response.body;
      jsonBody = returnBody ? json.decode(responseBody) : null;
    } catch (_) {}
    return ApiCallResponse(
      jsonBody,
      response.headers,
      response.statusCode,
      response: response,
    );
  }

  static ApiCallResponse fromCloudCallResponse(Map<String, dynamic> response) =>
      ApiCallResponse(
        response['body'],
        ApiManager.toStringMap(response['headers'] ?? {}),
        response['statusCode'] ?? 400,
      );
}

class ApiManager {
  ApiManager._();

  static ApiManager? _instance;
  static ApiManager get instance => _instance ??= ApiManager._();

  static Map<String, String> toStringMap(Map map) =>
      map.map((key, value) => MapEntry(key.toString(), value.toString()));

  static String asQueryParams(Map<String, dynamic> map) =>
      map.entries.map((e) => "${e.key}=${e.value}").join('&');

  static Future<ApiCallResponse> urlRequest(
    ApiCallType callType,
    String apiUrl,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    bool returnBody,
  ) async {
    if (params.isNotEmpty) {
      final lastUriPart = apiUrl.split('/').last;
      final needsParamSpecifier = !lastUriPart.contains('?');
      apiUrl =
          '$apiUrl${needsParamSpecifier ? '?' : ''}${asQueryParams(params)}';
    }
    final makeRequest = callType == ApiCallType.GET ? http.get : http.delete;
    final response =
        await makeRequest(Uri.parse(apiUrl), headers: toStringMap(headers));
    return ApiCallResponse.fromHttpResponse(response, returnBody);
  }

  static Future<ApiCallResponse> requestWithBody(
    ApiCallType type,
    String apiUrl,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    String? body,
    BodyType? bodyType,
    bool returnBody,
  ) async {
    assert(
      {ApiCallType.POST, ApiCallType.PUT, ApiCallType.PATCH}.contains(type),
      'Invalid ApiCallType $type for request with body',
    );
    final postBody = createBody(headers, params, body, bodyType);

    final requestFn = {
      ApiCallType.POST: http.post,
      ApiCallType.PUT: http.put,
      ApiCallType.PATCH: http.patch,
    }[type]!;
    final response = await requestFn(Uri.parse(apiUrl),
        headers: toStringMap(headers), body: postBody);
    return ApiCallResponse.fromHttpResponse(response, returnBody);
  }

  static dynamic createBody(
    Map<String, dynamic> headers,
    Map<String, dynamic>? params,
    String? body,
    BodyType? bodyType,
  ) {
    String? contentType;
    dynamic postBody;
    switch (bodyType) {
      case BodyType.JSON:
        contentType = 'application/json';
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.TEXT:
        contentType = 'text/plain';
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.X_WWW_FORM_URL_ENCODED:
        contentType = 'application/x-www-form-urlencoded';
        postBody = toStringMap(params ?? {});
        break;
      case BodyType.MULTIPART:
        contentType = 'multipart/form-data';
        postBody = params;
        break;
      case BodyType.NONE:
      case null:
        break;
    }

    if (contentType != null &&
        !headers.keys.any((h) => h.toLowerCase() == 'content-type')) {
      headers['Content-Type'] = contentType;
    }
    return postBody is String ? utf8.encode(postBody) : postBody;
  }

  Future<ApiCallResponse> makeApiCall({
    required String callName,
    required String apiUrl,
    required ApiCallType callType,
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> params = const {},
    String? body,
    BodyType? bodyType,
    bool returnBody = true,
    bool cache = false,
  }) async {
    if (!apiUrl.startsWith('http')) {
      apiUrl = 'https://$apiUrl';
    }

    ApiCallResponse result;
    switch (callType) {
      case ApiCallType.GET:
      case ApiCallType.DELETE:
        result = await urlRequest(
          callType,
          apiUrl,
          headers,
          params,
          returnBody,
        );
        break;
      case ApiCallType.POST:
      case ApiCallType.PUT:
      case ApiCallType.PATCH:
        result = await requestWithBody(
          callType,
          apiUrl,
          headers,
          params,
          body,
          bodyType,
          returnBody,
        );
        break;
    }

    return result;
  }
}
