import 'package:trady/list/Item.dart';
import 'package:trady/list/itemlist.dart';

class Tutorial {
  String title;
  String description;
  Header author;
  List<Tag> tags;
  Tutorial(this.title, this.description,this.author,[this.tags]);
  factory Tutorial.fromJson(dynamic json) {
    if (json['tags'] != null) {
      var tagObjsJson = json['tags'] as List;
      List<Tag> _tags = tagObjsJson.map((tagJson) => Tag.fromJson(tagJson)).toList();
      return Tutorial(
        json['title'] as String,
        json['description'] as String,
        Header.fromJson(json['author']),
        _tags
      );
    } else {
      return Tutorial(
        json['title'] as String,
        json['description'] as String,
       Header.fromJson(json['author'])
      );
    }
  }
  @override
  String toString() {
    return '{ ${this.title}, ${this.description},${this.author}, ${this.tags} }';
  }
}