import '/backend/api_requests/api_calls.dart';
import '../../utils/animations.dart';
import '../../utils/autocomplete_options_list.dart';
import '../../utils/app_theme.dart';
import '../../utils/util.dart';
import '/screens/pokemon/pokemon_widget.dart';
import '../../utils/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final animationsMap = {
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    _model.textController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: AppTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Pokémon Challenge',
            style: AppTheme.of(context).displaySmall.override(
                  fontFamily: 'Outfit',
                  color: AppTheme.of(context).tertiary,
                ),
          ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child:
              // Container with api call
              FutureBuilder<ApiCallResponse>(
            future: ListPokemonsApiCallCall.call(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: SpinKitSquareCircle(
                      color: AppTheme.of(context).primary,
                      size: 50.0,
                    ),
                  ),
                );
              }
              final containerListPokemonsApiCallResponse = snapshot.data!;
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF272727),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Lottie.asset(
                            'assets/lottie_animations/96855-pokeball-loading-animation.json',
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.contain,
                            repeat: false,
                            animate: true,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 0.0, 0.0),
                              child: Text(
                                '¡Bienvenido Maestro Pokémon!',
                                textAlign: TextAlign.center,
                                style:
                                    AppTheme.of(context).headlineSmall.override(
                                          fontFamily: 'Outfit',
                                          color: AppTheme.of(context)
                                              .primaryBackground,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 8.0, 12.0, 8.0),
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Color(0x790E151B),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8.0, 0.0, 8.0, 0.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 4.0, 0.0),
                                          child: Icon(
                                            Icons.search_rounded,
                                            color: Color(0xFFACB9C4),
                                            size: 24.0,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    8.0, 0.0, 8.0, 0.0),
                                            child: Autocomplete<String>(
                                              initialValue: TextEditingValue(),
                                              optionsBuilder:
                                                  (textEditingValue) {
                                                if (textEditingValue.text ==
                                                    '') {
                                                  return const Iterable<
                                                      String>.empty();
                                                }
                                                return (ListPokemonsApiCallCall
                                                        .name(
                                                  containerListPokemonsApiCallResponse
                                                      .jsonBody,
                                                ) as List)
                                                    .map<String>(
                                                        (s) => s.toString())
                                                    .toList()
                                                    .where((option) {
                                                  final lowercaseOption =
                                                      option.toLowerCase();
                                                  return lowercaseOption
                                                      .contains(textEditingValue
                                                          .text
                                                          .toLowerCase());
                                                });
                                              },
                                              optionsViewBuilder: (context,
                                                  onSelected, options) {
                                                return AutocompleteOptionsList(
                                                  textFieldKey:
                                                      _model.textFieldKey,
                                                  textController:
                                                      _model.textController!,
                                                  options: options.toList(),
                                                  onSelected: onSelected,
                                                  textStyle:
                                                      AppTheme.of(context)
                                                          .bodyMedium,
                                                  textHighlightStyle:
                                                      TextStyle(),
                                                  elevation: 4.0,
                                                  optionBackgroundColor:
                                                      AppTheme.of(context)
                                                          .secondaryText,
                                                  optionHighlightColor:
                                                      AppTheme.of(context)
                                                          .tertiary,
                                                  maxHeight: 200.0,
                                                );
                                              },
                                              onSelected: (String selection) {
                                                setState(() => _model
                                                        .textFieldSelectedOption =
                                                    selection);
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              fieldViewBuilder: (
                                                context,
                                                textEditingController,
                                                focusNode,
                                                onEditingComplete,
                                              ) {
                                                _model.textController =
                                                    textEditingController;
                                                return TextFormField(
                                                  key: _model.textFieldKey,
                                                  controller:
                                                      textEditingController,
                                                  focusNode: focusNode,
                                                  onEditingComplete:
                                                      onEditingComplete,
                                                  onChanged: (_) =>
                                                      EasyDebounce.debounce(
                                                    '_model.textController',
                                                    Duration(
                                                        milliseconds: 1000),
                                                    () => setState(() {}),
                                                  ),
                                                  onFieldSubmitted: (_) async {
                                                    _model.apiResultdux =
                                                        await PokemonApiCallCall
                                                            .call(
                                                      id: functions
                                                          .firstWordToMinus(
                                                              _model
                                                                  .textController
                                                                  .text),
                                                    );
                                                    if ((_model.apiResultdux
                                                            ?.succeeded ??
                                                        true)) {
                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PokemonWidget(
                                                            pakemonJson: (_model
                                                                    .apiResultdux
                                                                    ?.jsonBody ??
                                                                ''),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return AlertDialog(
                                                            title:
                                                                Text('Error'),
                                                            content: Text(
                                                                'El pokémon no existe'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext),
                                                                child:
                                                                    Text('Ok'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }

                                                    setState(() {});
                                                  },
                                                  textCapitalization:
                                                      TextCapitalization.none,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText: 'Buscar pokémon',
                                                    hintStyle: AppTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Readex Pro',
                                                          color:
                                                              Color(0xFFDCDCDC),
                                                        ),
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    focusedErrorBorder:
                                                        InputBorder.none,
                                                    suffixIcon: _model
                                                            .textController!
                                                            .text
                                                            .isNotEmpty
                                                        ? InkWell(
                                                            onTap: () async {
                                                              _model
                                                                  .textController
                                                                  ?.clear();
                                                              setState(() {});
                                                            },
                                                            child: Icon(
                                                              Icons.clear,
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                              size: 15.0,
                                                            ),
                                                          )
                                                        : null,
                                                  ),
                                                  style: AppTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            Color(0xFFDCDCDC),
                                                      ),
                                                  validator: _model
                                                      .textControllerValidator
                                                      .asValidator(context),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Builder(
                            builder: (context) {
                              final pokemonsNoSearch =
                                  ListPokemonsApiCallCall.listPokemon(
                                        containerListPokemonsApiCallResponse
                                            .jsonBody,
                                      )?.toList() ??
                                      [];
                              return CustomScrollView(
                                slivers: [
                                  SliverPadding(
                                    padding: EdgeInsets.only(bottom: 12),
                                    sliver: SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          final pokemonsNoSearchItem =
                                              pokemonsNoSearch[index];
                                          return Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10),
                                            child:
                                                FutureBuilder<ApiCallResponse>(
                                              future: PokemonApiCallCall.call(
                                                id: (index + 1).toString(),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child:
                                                          SpinKitSquareCircle(
                                                        color:
                                                            AppTheme.of(context)
                                                                .primary,
                                                        size: 50,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final containerPokemonApiCallResponse =
                                                    snapshot.data!;
                                                return InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PokemonWidget(
                                                          pakemonJson:
                                                              containerPokemonApiCallResponse
                                                                  .jsonBody,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 113,
                                                    decoration: BoxDecoration(
                                                      color: Color(0x790E151B),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child: Hero(
                                                            tag:
                                                                PokemonApiCallCall
                                                                    .img(
                                                              containerPokemonApiCallResponse
                                                                  .jsonBody,
                                                            ),
                                                            transitionOnUserGestures:
                                                                true,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child:
                                                                  Image.network(
                                                                PokemonApiCallCall
                                                                    .img(
                                                                  containerPokemonApiCallResponse
                                                                      .jsonBody,
                                                                ),
                                                                width: 104,
                                                                height: 200,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  functions
                                                                      .firstWordToMayus(
                                                                          getJsonField(
                                                                    pokemonsNoSearchItem,
                                                                    r'''$.name''',
                                                                  ).toString()),
                                                                  'null',
                                                                ),
                                                                style: AppTheme.of(
                                                                        context)
                                                                    .headlineMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Outfit',
                                                                      color: AppTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                              ),
                                                              SizedBox(
                                                                  height: 6),
                                                              RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          'Peso: ',
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text: PokemonApiCallCall
                                                                          .weight(
                                                                        containerPokemonApiCallResponse
                                                                            .jsonBody,
                                                                      ).toString(),
                                                                      style:
                                                                          TextStyle(),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          ' kg',
                                                                      style:
                                                                          TextStyle(),
                                                                    )
                                                                  ],
                                                                  style: AppTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Readex Pro',
                                                                        fontSize:
                                                                            15,
                                                                      ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 6),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'Tipo: ',
                                                                    style: AppTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Readex Pro',
                                                                          color:
                                                                              AppTheme.of(context).primary,
                                                                        ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          functions
                                                                              .separateStrings(
                                                                            (PokemonApiCallCall.typeNames(
                                                                              containerPokemonApiCallResponse.jsonBody,
                                                                            ) as List)
                                                                                .map<String>((s) => s.toString())
                                                                                .toList()
                                                                                .toList(),
                                                                          ),
                                                                          'null',
                                                                        ),
                                                                        style: AppTheme.of(context)
                                                                            .bodyMedium,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 8),
                                                          child: Card(
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            color: AppTheme.of(
                                                                    context)
                                                                .secondaryBackground,
                                                            elevation: 4,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: Icon(
                                                              Icons.play_arrow,
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .tertiary,
                                                              size: 24,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        childCount: pokemonsNoSearch.length,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
