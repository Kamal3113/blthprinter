class Header {
  String name;
  int age;
  Header(this.name, this.age);
  factory Header.fromJson(dynamic json) {
    return Header(json['name'] as String, json['age'] as int);
  }
  @override
  String toString() {
    return '{ ${this.name}, ${this.age} }';
  }
}