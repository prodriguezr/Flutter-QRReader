class ScanModel {
  int? id;
  String type;
  String value;

  ScanModel({
    this.id,
    this.type = '',
    required this.value,
  }) {
    if (this.value.toLowerCase().contains('http')) {
      this.type = 'http';
    } else {
      this.type = 'geo';
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };

  //factory ScanModel.fromJson(String str) => ScanModel.fromMap(json.decode(str));

  //String toJson() => json.encode(toMap());

  factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "value": value,
      };
}
