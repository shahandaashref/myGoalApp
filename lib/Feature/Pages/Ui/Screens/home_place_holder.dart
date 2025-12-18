import 'package:flutter/material.dart';
import 'package:goal_app/Feature/Pages/Ui/Screens/add_goal_screen.dart';
import 'package:goal_app/Feature/Pages/Ui/Screens/home_Screen.dart';
import 'package:goal_app/Feature/Pages/Ui/Screens/stats_scteen.dart';

class HomePlaceHolder extends StatefulWidget {
  const HomePlaceHolder({super.key});

  @override
  State<HomePlaceHolder> createState() => _HomePlaceHolderState();
}

class _HomePlaceHolderState extends State<HomePlaceHolder> {
  PageController controller = PageController(initialPage: 0);
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(

        controller: controller,
        onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
        children: [HomeScreen(), AddGoalScreen(), StatsScteen()],
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentPage = value;
          });
          controller.jumpToPage(value);
        },
        selectedItemColor: const Color(0xff6DD4C4),
        currentIndex: _currentPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.area_chart), label: 'Stats'),
        ],
      ),
    );
  }
}
