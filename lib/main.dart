import 'package:MacroBridge/screens/home_screen.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import "theme.dart";

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // Application Root
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: "MacroBridge",

          themeMode: ThemeMode.system,
          theme: AppMaterialTheme.getThemeDataFromColorScheme(
            colorScheme: lightDynamic,
            brightness: Brightness.light,
          ),
          darkTheme: AppMaterialTheme.getThemeDataFromColorScheme(
            colorScheme: darkDynamic,
            brightness: Brightness.dark,
          ),

          home: const HomeScreen(),
        );
      },
    );
  }
}
