class Xarajat {
  String id;
  double summa;
  String category;
  DateTime date;
  String description;

  Xarajat({
    required this.id,
    required this.summa,
    required this.category,
    required this.date,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'summa': summa,
      'category': category,
      'date': date.toIso8601String(),
      'description': description,
    };
  }

  factory Xarajat.fromMap(Map<String, dynamic> map) {
    return Xarajat(
      id: map['id'] as String,
      summa: map['summa'] as double,
      category: map['category'] as String,
      date: DateTime.parse(map['date']),
      description: map['description'] as String,
    );
  }
}
