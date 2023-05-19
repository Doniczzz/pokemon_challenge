import 'package:flutter/material.dart';
import 'package:json_path/json_path.dart';

export 'models.dart';
export 'dart:math' show min, max;
export 'dart:typed_data' show Uint8List;
export 'dart:convert' show jsonEncode, jsonDecode;

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

dynamic getJsonField(
  dynamic response,
  String jsonPath, [
  bool isForList = false,
]) {
  final field = JsonPath(jsonPath).read(response);
  if (field.isEmpty) {
    return null;
  }
  if (field.length > 1) {
    return field.map((f) => f.value).toList();
  }
  final value = field.first.value;
  return isForList && value is! Iterable ? [value] : value;
}

extension TextEditingControllerExt on TextEditingController? {
  String get text => this == null ? '' : this!.text;
  set text(String newText) => this?.text = newText;
}
