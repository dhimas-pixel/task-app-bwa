class URLs {
  static const host = 'http://192.168.110.113:8080';
  static String image(String fileName) => '$host/attachments/$fileName';
}
