import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'service/firebase_options.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';
import 'widgets/main_bottom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final prefs = await SharedPreferences.getInstance();

    bool languageSwitchValue = prefs.getBool('languageSwitchValue') ?? false;
    Locale initialLocale =
        languageSwitchValue ? const Locale('en') : const Locale('th');
    bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;

    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('th'), Locale('en')],
        path: 'assets/translations',
        saveLocale: true,
        fallbackLocale: const Locale('th'),
        startLocale: initialLocale,
        child: ChangeNotifierProvider(
          create: (_) => ThemeProvider()..setDarkTheme(isDarkTheme),
          child: const MyApp(),
        ),
      ),
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: Provider.of<ThemeProvider>(context).isDarkTheme
          ? themeDataDark
          : themeDataLight,
      debugShowCheckedModeBanner: false,
      home: const MainBottom(),
    );
  }
}
