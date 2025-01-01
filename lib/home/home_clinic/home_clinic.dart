import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../firebase/dental_clinic.dart';
import '../../model/drawer_screen.dart';
import 'clinic_detail.dart';

class HomeClinic extends StatefulWidget {
  const HomeClinic({super.key});

  @override
  State<HomeClinic> createState() => _HomeClinicState();
}

class _HomeClinicState extends State<HomeClinic> {
  bool _isSearching = false;
  bool isLoading = false;
  List<ClinicFirebase> _allResults = [];
  List<ClinicFirebase> _resultList = [];

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    getClientStream();
    _focusNode.requestFocus();
  }

  _onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    setState(() {
      if (_searchController.text.isNotEmpty) {
        _resultList = _allResults.where((clinic) {
          return clinic.name
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
        }).toList();
      } else {
        _resultList = List.from(_allResults);
      }
    });
  }

  Future<void> getClientStream() async {
    var data = await FirebaseFirestore.instance
        .collection('Dental_Clinic')
        .orderBy('name')
        .get();

    if (mounted) {
      setState(() {
        _allResults =
            data.docs.map((doc) => ClinicFirebase.fromFirestore(doc)).toList();
        searchResultList();
      });
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
    _focusNode.requestFocus();
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
    _focusNode.unfocus();
  }

  String _formatWorkingDays(List<Map<String, dynamic>> workingDays) {
    // รายชื่อวันในภาษาไทย
    const daysInThai = [
      "วันจันทร์",
      "วันอังคาร",
      "วันพุธ",
      "วันพฤหัสบดี",
      "วันศุกร์",
      "วันเสาร์",
      "วันอาทิตย์"
    ];

    // ดึงชื่อวันจาก workingDays
    final openedDays = workingDays.map((dayMap) => dayMap['day']).toList();

    // ตรวจสอบว่าครอบคลุมทุกวันหรือไม่
    if (openedDays.length == 7 ||
        ListEquality().equals(openedDays, daysInThai)) {
      return "เปิดทุกวัน";
    }

    // หากวันเริ่มต้นที่จันทร์และจบที่อาทิตย์
    if (openedDays.contains("วันจันทร์") && openedDays.contains("วันอาทิตย์")) {
      return "วันจันทร์ ถึง วันอาทิตย์";
    }

    // แสดงรายการวันทำการแบบปกติ
    return openedDays.join(", ");
  }

  Widget createWidget(ClinicFirebase clinic) => Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ClinicDetail(
                    clinicData: clinic,
                  );
                },
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: Colors.grey[200]!,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clinic.name,
                    style: GoogleFonts.k2d(
                      textStyle: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).splashColor),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  if (clinic.workingDays.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'วันเปิดทำการ: ',
                          style: GoogleFonts.k2d(
                            textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).splashColor),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        Expanded(
                          child: Text(
                            _formatWorkingDays(clinic.workingDays),
                            style: GoogleFonts.k2d(
                              textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).splashColor),
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: _isSearching
            ? CupertinoSearchTextField(
                controller: _searchController,
                focusNode: _focusNode, // เพิ่ม FocusNode
                itemColor: Theme.of(context).dividerColor,
                style: TextStyle(color: Colors.white),
                // placeholder: 'Search Clinics...',
              )
            : Text(
                tr('app.Clinic'),
                style: GoogleFonts.k2d(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            color: Colors.white,
            onPressed: () {
              if (_isSearching) {
                _stopSearch();
              } else {
                _startSearch();
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).hoverColor,
              ),
            )
          : _resultList.isEmpty
              ? Center(
                  child: Text(
                    'ไม่พบคลินิกที่ค้นหา',
                    style: GoogleFonts.k2d(
                      textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).splashColor,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _resultList.length,
                  itemBuilder: (BuildContext context, int index) {
                    ClinicFirebase clinicData = _resultList[index];
                    return createWidget(clinicData);
                  },
                ),
    );
  }
}
