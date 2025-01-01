import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/theme_provider.dart';
import '../call/call.dart';

class HomeSupport extends StatefulWidget {
  const HomeSupport({super.key});

  @override
  _HomeSupportState createState() => _HomeSupportState();
}

class _HomeSupportState extends State<HomeSupport> {
  bool _languageSwitchValue = false;
  late SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> openPDF(BuildContext context) async {
    try {
      // Load file from assets
      final byteData = await rootBundle.load('assets/pdf/Application.pdf');

      // Create a temporary file in app's directory
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/Application.pdf');

      // Write the PDF file to the system
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());

      // Open the PDF file
      await OpenFile.open(tempFile.path);
    } catch (e) {
      // Handle the error
      if (kDebugMode) {
        print("Could not open PDF file: $e");
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error opening PDF file')),
      );
    }
  }

  Future<void> _loadPreferences() async {
    try {
      _preferences = await SharedPreferences.getInstance();
      _languageSwitchValue = _preferences.getBool('languageSwitchValue') ?? false;
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print("Error loading preferences: $e");
      }
    }
  }

  Future<void> changeLanguage(bool value) async {
    if (_languageSwitchValue != value) {
      setState(() {
        _languageSwitchValue = value;
      });
      if (value) {
        await context.setLocale(const Locale('en'));
      } else {
        await context.setLocale(const Locale('th'));
      }
      await _preferences.setBool('languageSwitchValue', value);
    }
  }

  Widget _languageSwitch() {
    if (Platform.isIOS) {
      return CupertinoSwitch(
        onChanged: (value) => changeLanguage(value),
        value: _languageSwitchValue,
      );
    } else {
      return Switch(
        onChanged: (value) => changeLanguage(value),
        value: _languageSwitchValue,
      );
    }
  }

  Widget _themeSwitch() {
    if (Platform.isIOS) {
      return CupertinoSwitch(
        onChanged: (value) {
          Provider.of<ThemeProvider>(context, listen: false).changeTheme();
          SharedPreferences.getInstance().then((prefs) {
            prefs.setBool('isDarkTheme', Provider.of<ThemeProvider>(context, listen: false).isDarkTheme);
          });
        },
        value: Provider.of<ThemeProvider>(context).isDarkTheme,
      );
    } else {
      return Switch(
        onChanged: (value) {
          Provider.of<ThemeProvider>(context, listen: false).changeTheme();
          SharedPreferences.getInstance().then((prefs) {
            prefs.setBool('isDarkTheme', Provider.of<ThemeProvider>(context, listen: false).isDarkTheme);
          });
        },
        value: Provider.of<ThemeProvider>(context).isDarkTheme,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // Adjust padding to be responsive
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  maxRadius: screenWidth * 0.2, // Adjust size according to screen width
                  backgroundImage: const AssetImage('assets/images/head_support.png'),
                ),
                Padding(
                  padding: EdgeInsets.all(screenHeight * 0.02), // Adjust padding
                  child: Text(
                    'D E N T A L  N E W S',
                    style: TextStyle(
                      fontSize: screenWidth * 0.08, // Adjust font size to be responsive
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                ),
                const Divider(height: 50),
                _buildListTile(
                  context,
                  screenWidth,
                  screenHeight,
                  title: tr('app.Language'),
                  subtitle: tr('app.LanguageDetel'),
                  icon: 'assets/images/language.png',
                  trailing: _languageSwitch(),
                ),
                const Divider(),
                _buildListTile(
                  context,
                  screenWidth,
                  screenHeight,
                  title: tr('app.Theme'),
                  subtitle: tr('app.Themesetting'),
                  icon: 'assets/images/theme.png',
                  trailing: _themeSwitch(),
                ),
                const Divider(),
                _buildListTile(
                  context,
                  screenWidth,
                  screenHeight,
                  title: tr('app.Manual'),
                  subtitle: tr('app.ManualTitle'),
                  icon: 'assets/images/setting.png',
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () => openPDF(context), // Open PDF function
                ),
                const Divider(),
                _buildListTile(
                  context,
                  screenWidth,
                  screenHeight,
                  title: tr('app.Help'),
                  subtitle: tr('app.HelpTile'),
                  icon: 'assets/images/service.png',
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const Call();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build ListTile
  Widget _buildListTile(
    BuildContext context,
    double screenWidth,
    double screenHeight, {
    required String title,
    required String subtitle,
    required String icon,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      title: _buildText(title),
      subtitle: _buildText(subtitle),
      leading: _buildIcon(icon),
      trailing: trailing,
    );
  }

  // Helper function to build Text widget
  Widget _buildText(String text) {
    return Text(
      text,
      style: GoogleFonts.k2d(
        textStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.045, // Responsive font size
          fontWeight: FontWeight.w500,
          // color: Theme.of(context).splashColor,
        ),
      ),
    );
  }

  // Helper function to build Icon widget
  Widget _buildIcon(String icon) {
    return Image.asset(
      icon,
      width: MediaQuery.of(context).size.width * 0.09, // Responsive icon size
      height: MediaQuery.of(context).size.height * 0.05, // Responsive icon size
    );
  }
}
