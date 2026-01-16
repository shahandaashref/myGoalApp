import 'package:flutter/material.dart';
import 'package:goal_app/Feature/Pages/model/goal_data.dart';
import 'package:goal_app/Feature/Pages/model/sqldb.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  bool? goalIsDone = false;
  bool isLoading = true;
  SqlDb sqlDb = SqlDb();
  List<Goal> myGoals = [];
 

  @override
  void initState() {
    super.initState();
    loadData();
  }
   Future<void> loadData() async {
    List<Goal> data = await sqlDb.readData();
    setState(() {
      myGoals = data;
      isLoading = false;
    });
  }

  void _toggleGoal(Goal goal, bool newVal) async {
    Goal updatedGoal = Goal(
      id: goal.id,
      title: goal.title,
      isDone: newVal,
      date: goal.date,
    );

    await sqlDb.updateData(updatedGoal);
    loadData();
  }

  void _deleteGoal(int id) async {
    await sqlDb.deleteData(id);
    loadData();
  }

  DateTime getStartOfWeek() {
    DateTime now = DateTime.now();
    int daysSinceSaturday = (now.weekday % 7 + 1) % 7;
    return now.subtract(Duration(days: daysSinceSaturday));
  }

  @override
  Widget build(BuildContext context) {
    int totalGoals = myGoals.length;
    int completedGoals = myGoals.where((g) => g.isDone).length;
    double percent = totalGoals == 0 ? 0 : completedGoals / totalGoals;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning!',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              Text(
                "Let's make today count",
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),

              SizedBox(height: 20),

              ///number of  goals completed
              numberOfGoalsCompleted(completedGoals, totalGoals, percent),
              Text('This Week'),
              daysInThisWeek(),
              Text('Today\'s Goals'),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : myGoals.isEmpty
                  ? Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: Text("No goals yet. Start now!"),
                    )
                  : goalIteBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox goalIteBuilder() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: myGoals.length,
        shrinkWrap: true,
        //physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final goal = myGoals[index];
        
        
          return Container(
            alignment: Alignment.center,
            height: 100,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: const Color.fromARGB(255, 236, 236, 236),
                  offset: Offset(1, 1),
                ),
              ],
            ),

            child: Row(
              children: [
                /////////////////  Check is done /////////////////
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Color.fromARGB(255, 140, 226, 243),
                  shape: CircleBorder(),
                  value: goal.isDone,
                  onChanged: (val) {
                    _toggleGoal(goal, val!);
                  },
                ),

                ////////////////  gaol item text  ////////////////
                Expanded(
                  child: Text(
                    goal.title,
                    style: TextStyle(
                      fontSize: 18,
                      decoration: goal.isDone
                          ? TextDecoration.lineThrough
                          : null,
                      color: goal.isDone ? Colors.grey : Colors.black87,
                    ),
                  ),
                ),

                ///////////  to delete goal from database  ////////////
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.redAccent),
                  onPressed: () => _deleteGoal(goal.id!),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox daysInThisWeek() {
    DateTime startOfWeek = getStartOfWeek();
    return SizedBox(
      height: 110,
      child: ListView.builder(
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          DateTime date = startOfWeek.add(Duration(days: index));
          bool isSelected =
              DateFormat('d').format(date) ==
              DateFormat('d').format(selectedDate);

          bool isToday =
              DateFormat('d').format(date) ==
              DateFormat('d').format(DateTime.now());
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(8),
              width: 70,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: isSelected
                    ? Color.fromARGB(255, 140, 226, 243)
                    : Colors.grey[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                border: isSelected
                    ? Border.all(color: Colors.transparent)
                    : Border.all(color: Colors.grey.shade200),
              ),

              child: Text.rich(
                TextSpan(
                  text: DateFormat('E').format(date),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontSize: 18,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "\n ${DateFormat('d').format(date)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container numberOfGoalsCompleted(int done, int total, double percent) {
    return Container(
      alignment: Alignment.center,
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xffB4E7CE),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 2,
            color: const Color.fromARGB(255, 206, 206, 206),
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Daily Progress",
            style: TextStyle(fontSize: 20, color: Colors.grey[700]),
          ),
          SizedBox(height: 20),
          CircularPercentIndicator(
            radius: 70.0,
            lineWidth: 10.0,
            percent: percent,
            center: Text("    $done / $total \ncompleted"),
            progressColor: const Color.fromARGB(255, 97, 206, 228),
          ),
        ],
      ),
    );
  }
}
