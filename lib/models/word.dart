class Word {
  int? id;
  String? enWord;
  String? type;
  String? translation;
  String? description;
  String? countable;
  int? favourite;

  Word(
      {this.id,
        this.enWord,
        this.type,
        this.translation,
        this.description,
        this.countable,
        this.favourite});

  Word.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enWord = json['enWord'];
    type = json['type'];
    translation = json['translation'];
    description = json['description'];
    countable = json['countable'];
    favourite = json['favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enWord'] = this.enWord;
    data['type'] = this.type;
    data['translation'] = this.translation;
    data['description'] = this.description;
    data['countable'] = this.countable;
    data['favourite'] = this.favourite;
    return data;
  }


  Word.fromMap(Map<String, Object?> map) {
    id = (map["id"] as int?)!;
    enWord = (map["enWord"] as String?)!;
    type = (map["type"] as String?)!;
    translation = (map["translation"] as String?)!;
    description = (map["description"] as String?)!;
    countable = (map["countable"] as String?)!;
    favourite = (map["favourite"] as int?)!;
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "enWord": enWord,
      "type": type,
      "translation": translation,
      "description": description,
      "countable": countable,
      "favourite": favourite,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
  
}
