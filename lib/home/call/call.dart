import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class Call extends StatefulWidget {
  const Call({Key? key}) : super(key: key);

  @override
  _personState createState() => _personState();
}

Future<void> _launchUrl(BuildContext context, Uri uri) async {
  try {
    final bool canLaunch = await canLaunchUrl(uri);
    if (canLaunch) {
      await launchUrl(uri,
          mode: LaunchMode.externalApplication); // ใช้ externalApplication
    } else {
      throw 'Could not launch $uri';
    }
  } catch (e) {
    // แสดงข้อผิดพลาดถ้าไม่สามารถเปิด URL ได้
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'.tr()), // แปลข้อความด้วย easy_localization
        content: Text(e.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'.tr()),
          ),
        ],
      ),
    );
  }
}

class _personState extends State<Call> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(LineIcons.chevronCircleLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.map_outlined),
              onPressed: () {
                final Uri uri =
                    Uri.parse('https://goo.gl/maps/9t8CYvrkfnLx99rLA');
                _launchUrl(context, uri); // ส่ง context ไปยังฟังก์ชัน
              },
            ),
          ),
        ],
        title: Text(
          tr("app.call"),
          style: GoogleFonts.k2d(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'CDEC',
                style: TextStyle(fontSize: 60),
              ),
              const Text(
                'ศูนย์การศึกษาต่อเนื่องของทันตแพทย์ ทันตแพทยสภา',
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 30),
              const Text(
                'ที่อยู่:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                '88/19 หมู่ที่ 4 ชั้น 5 อาคารสภาวิชาชีพ\nซอยสาธารณสุข 8 กระทรวงสาธารณสุข \nถนนติวานนท์ ตำบลตลาดขวัญ \nอำเภอเมือง จังหวัดนนทบุรี 11000',
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 20),
              const Text(
                'เบอร์โทรศัพท์:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () =>
                    _launchUrl(context, Uri(scheme: 'tel', path: '025807500')),
                child: const Text(
                  '02 580 7500 ถึง 3',
                  style: TextStyle(fontSize: 17, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'อีเมล:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () => _launchUrl(context,
                    Uri(scheme: 'mailto', path: 'dent11@dentalcouncil.or.th')),
                child: const Text(
                  'dent11@dentalcouncil.or.th',
                  style: TextStyle(fontSize: 17, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => _launchUrl(context,
                    Uri(scheme: 'mailto', path: 'cdec_center@yahoo.com')),
                child: const Text(
                  'cdec_center@yahoo.com',
                  style: TextStyle(fontSize: 17, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => _launchUrl(context,
                    Uri(scheme: 'mailto', path: 'cdec@dentalcouncil.or.th')),
                child: const Text(
                  'cdec@dentalcouncil.or.th',
                  style: TextStyle(fontSize: 17, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () => _launchUrl(
                    context, Uri(scheme: 'mailto', path: 'cdathai@gmail.com')),
                child: const Text(
                  'cdathai@gmail.com',
                  style: TextStyle(fontSize: 17, color: Colors.blue),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
