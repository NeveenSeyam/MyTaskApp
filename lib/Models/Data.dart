class Data {
  int id;
  String title;
  int checkValue;

  Data(
    this.title,
    this.checkValue,
  );

  Data.withId(
    this.id,
    this.title,
    this.checkValue,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = this.id;
    map["title"] = this.title;
    map["checkValue"] = this.checkValue;
    return map;
  }

  Data.getMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.title = map["title"];
    this.checkValue = map["checkValue"];
  }
}
