import '../../utils/util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class ListPokemonsApiCallCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'listPokemonsApiCall',
      apiUrl: 'https://pokeapi.co/api/v2/pokemon?limit=1281',
      callType: ApiCallType.GET,
      returnBody: true,
    );
  }

  static dynamic listPokemon(dynamic response) => getJsonField(
        response,
        r'''$.results''',
        true,
      );
  static dynamic name(dynamic response) => getJsonField(
        response,
        r'''$.results[:].name''',
      );
  static dynamic url(dynamic response) => getJsonField(
        response,
        r'''$.results[:].url''',
        true,
      );
}

class PokemonApiCallCall {
  static Future<ApiCallResponse> call({
    String? id = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'pokemonApiCall',
      apiUrl: 'https://pokeapi.co/api/v2/pokemon/$id/',
      callType: ApiCallType.GET,
      returnBody: true,
    );
  }

  static dynamic listNameAbilities(dynamic response) => getJsonField(
        response,
        r'''$.abilities''',
        true,
      );
  static dynamic abilities(dynamic response) => getJsonField(
        response,
        r'''$.abilities[:].ability.name''',
        true,
      );
  static dynamic baseExperience(dynamic response) => getJsonField(
        response,
        r'''$.base_experience''',
      );
  static dynamic name(dynamic response) => getJsonField(
        response,
        r'''$.forms[:].name''',
      );
  static dynamic height(dynamic response) => getJsonField(
        response,
        r'''$.height''',
      );
  static dynamic typeNames(dynamic response) => getJsonField(
        response,
        r'''$.types[:].type.name''',
        true,
      );
  static dynamic weight(dynamic response) => getJsonField(
        response,
        r'''$.weight''',
      );
  static dynamic img(dynamic response) => getJsonField(
        response,
        r'''$.sprites.other.home.front_default''',
      );
}
