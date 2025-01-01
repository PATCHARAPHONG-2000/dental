import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../data/list_title.dart';

class DentalBenefitsr extends StatefulWidget {
  const DentalBenefitsr({super.key});

  @override
  State<DentalBenefitsr> createState() => _DentalBenefitsrState();
}

class _DentalBenefitsrState extends State<DentalBenefitsr> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // ขนาดฟอนต์และระยะห่างพื้นฐาน
    double baseFontSize = screenWidth * 0.045;
    double basePadding = screenHeight * 0.02;

    // ดึงข้อมูล volunteer list
    List<Volunteere> volunteere = getVolunteereList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          tr('DB.Dental_Benefits'),
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
          itemCount: volunteere.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: basePadding / 3),
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
                      volunteere[index].name,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(
                          fontSize: baseFontSize + 2,
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
                      volunteere[index].lebbel,
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
