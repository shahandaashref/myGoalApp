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
  late PageController controller;
  int _currentPage = 0;
  Key homeKey = UniqueKey();
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

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
        children: [
          HomeScreen(key: homeKey),
          // AddGoalScreen(),
          StatsScteen(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) async {
          
          if (index == 1) { 
            // === لو داس على زرار الإضافة ===
            // 1. نفتح الصفحة ونستنى (await)
            var result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddGoalScreen()),
            );

            // 2. لو رجعنا بكلمة true (يعني حفظنا هدف)
            if (result == true) {
              setState(() {
                // 🔄 تغيير المفتاح ده بيخلي الهوم تعمل ريفرش
                homeKey = UniqueKey(); 
                
                // نرجع لصفحة الهوم
                _currentPage = 0; 
                controller.jumpToPage(0);
              });
            }
          } else {
            // التنقل العادي بين الصفحات
            setState(() {
              _currentPage = index;
            });
            controller.jumpToPage(index == 2 ? 1 : 0);
          }
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
