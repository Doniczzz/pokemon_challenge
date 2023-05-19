import '../../utils/icon_button.dart';
import '../../utils/app_theme.dart';
import '../../utils/util.dart';
import '../../utils/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'pokemon_model.dart';
export 'pokemon_model.dart';

class PokemonWidget extends StatefulWidget {
  const PokemonWidget({
    Key? key,
    required this.pakemonJson,
  }) : super(key: key);

  final dynamic pakemonJson;

  @override
  _PokemonWidgetState createState() => _PokemonWidgetState();
}

class _PokemonWidgetState extends State<PokemonWidget> {
  late PokemonModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PokemonModel());
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
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
            child: FIconButton(
              borderRadius: 20.0,
              borderWidth: 1.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: AppTheme.of(context).tertiary,
                size: 36.0,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text(
            valueOrDefault<String>(
              functions.firstWordToMayus(getJsonField(
                widget.pakemonJson,
                r'''$.name''',
              ).toString()),
              'null',
            ),
            style: AppTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: AppTheme.of(context).tertiary,
                  fontSize: 36.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF272727),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: getJsonField(
                              widget.pakemonJson,
                              r'''$.sprites.other.home.front_default''',
                            ),
                            transitionOnUserGestures: true,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                getJsonField(
                                  widget.pakemonJson,
                                  r'''$.sprites.other.home.front_default''',
                                ),
                                width: double.infinity,
                                height: 271.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            functions.firstWordToMayus(getJsonField(
                              widget.pakemonJson,
                              r'''$.name''',
                            ).toString()),
                            'null',
                          ),
                          style: AppTheme.of(context).headlineLarge.override(
                                fontFamily: 'Outfit',
                                fontSize: 40.0,
                              ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Tipo de pokémon',
                                style:
                                    AppTheme.of(context).headlineLarge.override(
                                          fontFamily: 'Outfit',
                                          color: AppTheme.of(context).alternate,
                                          fontSize: 20.0,
                                        ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  Icons.error,
                                  color: AppTheme.of(context).alternate,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 0.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.play_arrow_rounded,
                                  color: AppTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    valueOrDefault<String>(
                                      functions.detectString(getJsonField(
                                        widget.pakemonJson,
                                        r'''$.types[:].type.name''',
                                      )),
                                      'null',
                                    ),
                                    style: AppTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Habilidades',
                                style:
                                    AppTheme.of(context).headlineLarge.override(
                                          fontFamily: 'Outfit',
                                          color: AppTheme.of(context).alternate,
                                          fontSize: 20.0,
                                        ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  Icons.error,
                                  color: AppTheme.of(context).alternate,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 0.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.play_arrow_rounded,
                                  color: AppTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      valueOrDefault<String>(
                                        functions.detectString(getJsonField(
                                          widget.pakemonJson,
                                          r'''$.abilities[:].ability.name''',
                                        )),
                                        'null',
                                      ),
                                      textAlign: TextAlign.start,
                                      style: AppTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Caracteristicas',
                                style:
                                    AppTheme.of(context).headlineLarge.override(
                                          fontFamily: 'Outfit',
                                          color: AppTheme.of(context).alternate,
                                          fontSize: 20.0,
                                        ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 0.0, 0.0),
                                child: Icon(
                                  Icons.error,
                                  color: AppTheme.of(context).alternate,
                                  size: 24.0,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                25.0, 5.0, 0.0, 0.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.height,
                                        color: AppTheme.of(context).primaryText,
                                        size: 24.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5.0, 0.0, 0.0, 0.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Altura: ',
                                                style: AppTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          AppTheme.of(context)
                                                              .alternate,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  getJsonField(
                                                    widget.pakemonJson,
                                                    r'''$.height''',
                                                  ).toString(),
                                                  'null',
                                                ),
                                                style: TextStyle(),
                                              ),
                                              TextSpan(
                                                text: ' Metros',
                                                style: TextStyle(),
                                              )
                                            ],
                                            style: AppTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 20.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.line_weight_rounded,
                                        color: AppTheme.of(context).primaryText,
                                        size: 24.0,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            7.0, 0.0, 0.0, 0.0),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Peso: ',
                                                style: AppTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          AppTheme.of(context)
                                                              .alternate,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                              TextSpan(
                                                text: valueOrDefault<String>(
                                                  getJsonField(
                                                    widget.pakemonJson,
                                                    r'''$.weight''',
                                                  ).toString(),
                                                  'null',
                                                ),
                                                style: TextStyle(),
                                              ),
                                              TextSpan(
                                                text: ' kg',
                                                style: TextStyle(),
                                              )
                                            ],
                                            style: AppTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  fontSize: 20.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.escalator,
                                      color: AppTheme.of(context).primaryText,
                                      size: 24.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          7.0, 0.0, 0.0, 0.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'Experiencia base: ',
                                              style: AppTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: AppTheme.of(context)
                                                        .alternate,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: valueOrDefault<String>(
                                                getJsonField(
                                                  widget.pakemonJson,
                                                  r'''$.base_experience''',
                                                ).toString(),
                                                'null',
                                              ),
                                              style: TextStyle(),
                                            ),
                                            TextSpan(
                                              text: ' EXP',
                                              style: TextStyle(),
                                            )
                                          ],
                                          style: AppTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Readex Pro',
                                                fontSize: 20.0,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
