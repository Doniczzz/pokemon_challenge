import '/backend/api_requests/api_calls.dart';
import '../../utils/util.dart';
import 'package:flutter/material.dart';

class HomeModel extends Models {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  final textFieldKey = GlobalKey();
  TextEditingController? textController;
  String? textFieldSelectedOption;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (pokemonApiCall)] action in TextField widget.
  ApiCallResponse? apiResultdux;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Additional helper methods are added here.
}
