class Content {
  final String text;
  final String role; // กำหนด role ให้กับแต่ละข้อความ (user หรือ ai)

  Content.text(this.text, {this.role = 'user'});  // ค่าเริ่มต้นของ role คือ 'user'

  // หากมีข้อมูลประเภทอื่น ๆ ใน Content ที่ต้องการให้แสดงผล สามารถเพิ่มฟังก์ชันหรือพารามิเตอร์ได้
}
