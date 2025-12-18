class Goal {
  final int? id;       
  final String title;  
  final bool isDone;   
  final String date;   

  Goal({this.id, required this.title, required this.isDone, required this.date});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone ? 1 : 0, 
      'date': date,
    };
  }

 
  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['id'],
      title: map['title'],
      isDone: map['isDone'] == 1, 
      date: map['date'],
    );
  }
}