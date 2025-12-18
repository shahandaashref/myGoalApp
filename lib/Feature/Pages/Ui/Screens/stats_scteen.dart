import 'package:flutter/material.dart';

class StatsScteen extends StatefulWidget {
  const StatsScteen({super.key});

  @override
  State<StatsScteen> createState() => _StatsScteenState();
}

class _StatsScteenState extends State<StatsScteen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Progress',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Keep up the great work!",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),

                SizedBox(height: 20),

                Text('This Week'),
                streackCards(),
                Text('Weekly Consistency'),

              ],
            ),
          ),
        ),
      );
  }

  SizedBox streackCards() {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [


          StatCard(
            title: "Current\nStreak",
            value: "12",
            icon: Icons.trending_up,
            color: Colors.teal,
          ),
          
          SizedBox(width: 12), 


          StatCard(
            title: "Best\nStreak",
            value: "28",
            icon: Icons.workspace_premium, 
            color: Colors.pinkAccent,
          ),

          SizedBox(width: 12),

          StatCard(
            title: "Total\nDays",
            value: "94",
            icon: Icons.calendar_today,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({super.key, 
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), 
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha:  0.09),
            blurRadius: 5,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha:  0.1), 
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color, 
              size: 24,
            ),
          ),
          
          SizedBox(height: 12),
          

          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade900,
            ),
          ),
          
          SizedBox(height: 4),
          

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
