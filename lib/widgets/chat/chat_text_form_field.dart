import 'package:flutter/material.dart';

class ChatTextFormField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController? controller;
  final bool isRoadOnly;
  final void Function(String)? onFieldSubmitted;

  const ChatTextFormField({
    super.key,
    required this.focusNode,
    this.controller,
    this.isRoadOnly = false,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true, // เปิดการโฟกัสอัตโนมัติ
      autocorrect: false, // ปิดการแก้ไขข้อความอัตโนมัติ
      focusNode: focusNode,
      controller: controller,
      readOnly: isRoadOnly, // ควบคุมว่าฟิลด์เป็นแบบอ่านอย่างเดียวหรือไม่
      textInputAction: TextInputAction.send, // กำหนด Action ของคีย์บอร์ด
      onFieldSubmitted: onFieldSubmitted, // ฟังก์ชันที่เรียกใช้เมื่อกด Enter หรือปุ่ม Send
      decoration: InputDecoration(
        hintText: "พิมพ์ข้อความ...",
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "กรุณากรอกข้อความ";
        }
        return null;
      },
    );
  }
}
