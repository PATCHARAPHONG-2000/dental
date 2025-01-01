import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../data/list_title.dart';

class CustomerRights extends StatefulWidget {
  const CustomerRights({super.key});

  @override
  State<CustomerRights> createState() => _CustomerRightsState();
}

class _CustomerRightsState extends State<CustomerRights> {
 @override
  Widget build(BuildContext context) {
    double baseFontSize = MediaQuery.of(context).size.width * 0.045;
    double basePadding = MediaQuery.of(context).size.height * 0.02;

    List<Receipte> receipte = getReceipteList(); // เรียกใช้ getReceipteList()

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          tr('DPR.Dental_patient_rights'),
          style: GoogleFonts.k2d(
            textStyle: TextStyle(
              fontSize: baseFontSize + 5,
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
      body: Padding(
        padding: EdgeInsets.all(basePadding),
        child: ListView.builder(
          itemCount: receipte.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: basePadding),
              child: Container(
                padding: EdgeInsets.all(basePadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      receipte[index].name,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(
                          fontSize: baseFontSize + 3,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: basePadding / 2),
                    const Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                    ),
                    SizedBox(height: basePadding / 2),
                    Text(
                      receipte[index].lebbel,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(
                          fontSize: baseFontSize,
                          fontWeight: FontWeight.w300,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: basePadding),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
