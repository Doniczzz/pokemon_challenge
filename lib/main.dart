import 'package:flutter/material.dart';
import 'utils/app_theme.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  bool displaySplashImage = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(
        Duration(seconds: 1), () => setState(() => displaySplashImage = false));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Challenge',
      locale: _locale,
      theme: ThemeData(brightness: Brightness.light),
      themeMode: _themeMode,
      home: displaySplashImage
          ? Builder(
              builder: (context) => Container(
                color: AppTheme.of(context).primary,
                child: Center(
                  child: Image.asset(
                    'assets/images/Pokemon-Logo-PNG-Pic.png',
                    width: 350.0,
                    height: 350.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
          : HomeWidget(),
    );
  }
}
