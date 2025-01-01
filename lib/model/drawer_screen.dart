import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/drawer_detail/history_screen.dart';
import '../home/drawer_detail/policy_screen.dart';
import '../widgets/knowledge/knowledge_screen.dart';
import '../widgets/knowledge/knowledge_link_screen.dart';
import '../widgets/press_release/press_release_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}
class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    // MediaQuery to handle responsive padding, font size, and element size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: Theme.of(context).cardColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Responsive DrawerHeader with adjustable height
            SizedBox(
              height: screenHeight * 0.2, // Set height based on screen height
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage("assets/images/head_support.png"),
                  ),
                ),
                child: null,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Dental Council Header
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.03,
                            bottom: screenHeight * 0.01),
                        child: Text(
                          tr('app.Dental_Council'),
                          style: GoogleFonts.k2d(
                            textStyle: TextStyle(
                              fontSize:
                                  screenWidth * 0.05, // Responsive font size
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: screenHeight * 0.005,
                    color: Theme.of(context).splashColor,
                  ),
                  // List Items (History, Policy, etc.)
                  buildDrawerItem(
                    context,
                    screenWidth,
                    screenHeight,
                    icon: 'assets/images/streamline.png',
                    text: tr('His.HisH'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const HistoryScreen();
                        }),
                      );
                    },
                  ),
                  buildDrawerItem(
                    context,
                    screenWidth,
                    screenHeight,
                    icon: 'assets/images/pen.png',
                    text: tr('PDC.Policy_Dental_Council'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const PolicyScreen();
                        }),
                      );
                    },
                  ),
                  // Public Relations Header
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.015),
                    child: Row(
                      children: [
                        Text(
                          tr('app.Public_Relations'),
                          style: GoogleFonts.k2d(
                            textStyle: TextStyle(
                              fontSize:
                                  screenWidth * 0.05, // Responsive font size
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: screenHeight * 0.005,
                    color: Theme.of(context).splashColor,
                  ),
                  // List Items (Press Release, Knowledge, etc.)
                  buildDrawerItem(
                    context,
                    screenWidth,
                    screenHeight,
                    icon: 'assets/images/mic.png',
                    text: tr('app.Press_release'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const PressReleaseScreen();
                        }),
                      );
                    },
                  ),
                  buildDrawerItem(
                    context,
                    screenWidth,
                    screenHeight,
                    icon: 'assets/images/book.png',
                    text: tr('app.knowledge'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const KnowledgeScreen();
                        }),
                      );
                    },
                  ),
                  buildDrawerItem(
                    context,
                    screenWidth,
                    screenHeight,
                    icon: 'assets/images/link.png',
                    text: tr('app.knowledge_link'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const KnowledgeLinkScreen();
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build Drawer items with responsive layout
  ListTile buildDrawerItem(
      BuildContext context, double screenWidth, double screenHeight,
      {required String icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(
        text,
        style: GoogleFonts.k2d(
          textStyle: TextStyle(fontSize: screenWidth * 0.04),
        ),
      ),
      leading: Image.asset(
        icon,
        color: Theme.of(context).splashColor,
        width: screenWidth * 0.06, // Adjust icon size responsively
      ),
    );
  }
}
