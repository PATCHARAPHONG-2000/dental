import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../firebase/firebase.dart';
import '../../firebase/knowledge_link.dart';

class KnowledgeLinkScreen extends StatefulWidget {
  const KnowledgeLinkScreen({super.key});

  @override
  State<KnowledgeLinkScreen> createState() => _KnowledgeLinkScreenState();
}

class _KnowledgeLinkScreenState extends State<KnowledgeLinkScreen> {
  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Know_Link> linkDataList = await FireBaseData.knowledgLinkData();
    setState(() {
      widgets = linkDataList
          .map((newKnowledge) => knowledgeLinkWidget(newKnowledge))
          .toList();
    });
  }

  Future<void> _lunchUrl(Uri uri) async {
    if (!await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
    )) {
      throw 'Could not launch $uri';
    }
  }

  Widget knowledgeLinkWidget(Know_Link knowlink) => GestureDetector(
        onTap: () {
          final Uri uri = Uri.parse(knowlink.url);
          _lunchUrl(uri);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1.2,
                    color: Theme.of(context).hoverColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft, // จัดข้อความให้อยู่ชิดซ้าย
                  child: Text(
                    knowlink.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1, // จำกัดให้ข้อความแสดงแค่บรรทัดเดียว
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          tr('app.knowledge_link'),
          style: GoogleFonts.k2d(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(LineIcons.chevronCircleLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: widgets.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).hoverColor,
              ),
            )
          : ListView.builder(
              itemCount: widgets.length,
              itemBuilder: (context, index) {
                return widgets[index];
              },
            ),
    );
  }
}
