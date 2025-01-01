import 'package:flutter/material.dart';

import '../utils/utils.dart';

// Light theme
final ThemeData themeDataLight = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFF7F7F8), // พื้นหลังสีเทาอ่อน
  primaryColor: const Color(0xFF8009B8), // สีหลัก
  cardColor: const Color(0xFFFFFFFF), // สีการ์ด (สีขาว)
  hoverColor: const Color(0xFF8009B8), // สีเมื่อโฮเวอร์
  brightness: Brightness.light,
  splashColor: Color.fromRGBO(0, 0, 0, 1),
  focusColor: color.black,
  hintColor: const Color.fromARGB(255, 255, 255, 255), // สีคำแนะนำ
  disabledColor:
      const Color.fromARGB(255, 211, 3, 65), // สีเมื่อถูกปิดการใช้งาน
  highlightColor: const Color(0xFF7A0CAD), // สีไฮไลท์
  dividerColor: const Color(0xFF7A0CAD), // สีเส้นแบ่ง
  indicatorColor: const Color(0xFF8009B8), // สีตัวบ่งชี้
);

// Dark theme (สีเทา)
final ThemeData themeDataDark = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF2E2E2E), // พื้นหลังสีเทาเข้ม
  primaryColor:
      const Color.fromARGB(255, 54, 3, 65), // สีหลักในธีมมืด (ม่วงอ่อน)
  cardColor: const Color(0xFF3C3C3C), // สีการ์ดในธีมมืด (เทาเข้ม)
  hoverColor: const Color.fromARGB(255, 255, 255, 255), // สีเมื่อโฮเวอร์
  brightness: Brightness.dark,
  splashColor: color.white,
  focusColor: color.white,
  hintColor: const Color.fromARGB(255, 255, 255, 255), // สีคำแนะนำในธีมมืด
  disabledColor:
      const Color.fromARGB(255, 80, 80, 80), // สีเมื่อถูกปิดการใช้งานในธีมมืด
  highlightColor: const Color(0xFFBB86FC).withOpacity(0.2), // สีไฮไลท์
  dividerColor: Colors.grey[500], // สีเส้นแบ่งในธีมมืด (เทากลาง)
  indicatorColor: Colors.white, // สีตัวบ่งชี้ในธีมมืด
);
