import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase/data_care.dart';
import '../../firebase/firebase.dart';
import '../../model/drawer_screen.dart';
import '../../utils/utils.dart';
import 'care_detail.dart';


class HomeCare extends StatefulWidget {
  const HomeCare({super.key});

  @override
  _HomeCareState createState() => _HomeCareState();
}

class _HomeCareState extends State<HomeCare> {
  List<Widget> widgests = [];
  Map<String, bool> viewedItems = {}; // เก็บสถานะการเข้าชม

  @override
  void initState() {
    super.initState();
    loadViewedItems(); // โหลดสถานะการเข้าชม
    fetchData(); // ดึงข้อมูลจาก Firebase
  }

  // โหลดสถานะการเข้าชมจาก SharedPreferences
  Future<void> loadViewedItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        viewedItems = prefs.getKeys().fold<Map<String, bool>>({}, (map, key) {
          final value = prefs.get(key);
          if (value is bool) {
            map[key] = value;
          }
          return map;
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error loading viewed items: $e");
      }
    }
  }

  // บันทึกสถานะการเข้าชมลง SharedPreferences
  Future<void> markAsViewed(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(id, true); // บันทึกสถานะการเข้าชม
    setState(() {
      viewedItems[id] = true;
    });
  }

  Future<void> fetchData() async {
  // อ่านข้อมูลจาก Firebase
  List<Care_Data> careDataList = await FireBaseData.readData();

  // จัดเรียงให้รายการใหม่แสดงก่อน โดยเช็คว่ามีการดูแล้วหรือไม่
  careDataList.sort((a, b) {
    bool aIsNew = viewedItems[a.id] != true;
    bool bIsNew = viewedItems[b.id] != true;

    // รายการที่ยังไม่ได้ดู (id ใหม่) จะถูกจัดให้อยู่ข้างบน
    if (aIsNew && !bIsNew) return -1; // a ใหม่กว่า b
    if (!aIsNew && bIsNew) return 1; // b ใหม่กว่า a
    return 0; // ทั้งคู่เหมือนกัน ให้แสดงตามลำดับเดิม
  });

  // อัปเดตข้อมูลที่จะแสดง
  setState(() {
    widgests = careDataList.map((careData) => creatWidget(careData)).toList();
  });
}

  Widget creatWidget(Care_Data careData) {
    bool isNew = viewedItems[careData.id] != true; // เช็คสถานะการเข้าชม

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.22,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(careData.imageUrl),
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).focusColor,
                  width: 0.2,
                ),
              ),
              child: Stack(
                children: [
                  if (isNew) // แสดง "NEW" หากยังไม่เคยเข้าชม
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.width * 0.02,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.005,
                          horizontal: MediaQuery.of(context).size.width * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'NEW',
                          style: GoogleFonts.k2d(
                            textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            onTap: () {
              markAsViewed(careData.id);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => CareDetail(
                    care: careData,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          Text(
            careData.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.k2d(
              color: Theme.of(context).focusColor,
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w900,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).dividerColor,
        title: Text(
          tr('app.Care_teeth'),
          style: GoogleFonts.k2d(
            color: color.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: widgests.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).hoverColor,
              ),
            )
          : GridView.extent(
              childAspectRatio: 0.70,
              crossAxisSpacing: 0.5,
              mainAxisSpacing: 0.1,
              maxCrossAxisExtent: 350,
              children: widgests,
            ),
    );
  }
}
