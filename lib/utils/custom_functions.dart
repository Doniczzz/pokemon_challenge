String? separateStrings(List<String>? listString) {
  if (listString == null) {
    return null;
  }

  // Join the strings with a '/'.
  String separatedStrings = listString.join(' / ');

  return separatedStrings;
}

String detectString(dynamic typesNames) {
  if (typesNames is String) {
    return typesNames;
  }

  return typesNames.join(' / ');
}

String? firstWordToMinus(String? name) {
  if (name == null) {
    return null;
  }

  return name[0].toLowerCase() + name.substring(1);
}

String? firstWordToMayus(String? name) {
  if (name == null) {
    return null;
  }

  return name[0].toUpperCase() + name.substring(1);
}
