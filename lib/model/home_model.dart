import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/drawer_detail/payments_screen.dart';
import '../widgets/customer_rights.dart';
import '../widgets/dental_benefitsr.dart';

class HomeModel extends StatelessWidget {
  const HomeModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                tr('app.Category'),
                style: GoogleFonts.k2d(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          color: Theme.of(context).colorScheme.surface.withAlpha(9),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24.0),
            height: MediaQuery.of(context).size.height / 8.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return PaymentsScreen();
                        },
                      ),
                    );
                  },
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: Card(
                      shadowColor: Theme.of(context).splashColor,
                      color: Theme.of(context).dividerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tr('DS.Dental_service'),
                                  style: GoogleFonts.k2d(
                                    textStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const CustomerRights();
                        },
                      ),
                    );
                  },
                  child: Card(
                    shadowColor: Theme.of(context).splashColor,
                    color: Theme.of(context).dividerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                tr('DPR.Dental_patient_rights'),
                                style: GoogleFonts.k2d(
                                  textStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const DentalBenefitsr();
                        },
                      ),
                    );
                  },
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: Card(
                      shadowColor: Theme.of(context).splashColor,
                      color: Theme.of(context).dividerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 0.0, 10.0, 0.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  tr('DB.Dental_Benefits'),
                                  style: GoogleFonts.k2d(
                                    textStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ],
    );
  }
}
