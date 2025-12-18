// import 'package:flutter/material.dart';
// import 'package:goal_app/Custom/custom_text_field.dart';

// class AddGoalScreen extends StatefulWidget {
//   const AddGoalScreen({super.key});

//   @override
//   State<AddGoalScreen> createState() => _AddGoalScreenState();
// }

// class _AddGoalScreenState extends State<AddGoalScreen> {
//   final TextEditingController _controller = TextEditingController();
//   bool? goalIsDone = false;
//   GlobalKey _keyForm=GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _keyForm,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Add New Goal'),
//               CustomTextFormField(
//                 controller: _controller,
//                 type: 'text',
//                 label: 'Goal Title',
//                 hintText: 'goal',
//               ),
//               coalItem(),
//               SizedBox(height: 20),
//               Center(child: CustomBottom()),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   SizedBox coalItem() {
//     return SizedBox(
//       height: 120,
//       child: Container(
//         alignment: Alignment.center,
//         height: 100,
//         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
//         padding: EdgeInsets.all(16),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 2,
//               spreadRadius: 2,
//               color: const Color.fromARGB(255, 236, 236, 236),
//               offset: Offset(1, 1),
//             ),
//           ],
//         ),

//         child: Row(
//           //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Checkbox(
//               checkColor: Colors.white,
//               activeColor: Color.fromARGB(255, 140, 226, 243),
//               shape: CircleBorder(),
//               value: goalIsDone,
//               onChanged: (newValue) {
//                 setState(() {
//                   goalIsDone = newValue;
//                 });
//               },
//             ),
//             SizedBox(width: 15),
//             Text(_controller.text, style: TextStyle(fontSize: 20)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomBottom extends StatelessWidget {
//   const CustomBottom({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF64D2C2),
//         foregroundColor: Colors.white,
//         elevation: 0,

//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

//         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//       ),
//       child: const Text(
//         'Save Goal',
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:goal_app/Custom/custom_text_field.dart'; 
import 'package:goal_app/Feature/Pages/model/goal_data.dart';
import 'package:goal_app/Feature/Pages/model/sqldb.dart';


class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final TextEditingController _controller = TextEditingController();
  bool goalIsDone = false; 
  GlobalKey<FormState> _keyForm = GlobalKey(); // حددنا النوع FormState
  

  SqlDb sqlDb = SqlDb();


  void saveGoal() async {
    if (_keyForm.currentState!.validate()) {

      Goal newGoal = Goal(
        title: _controller.text,
        isDone: goalIsDone,
        date: DateTime.now().toString().split(" ")[0],
      );


      int response = await sqlDb.insertData(newGoal);
      
      if (response > 0) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Goal Added Successfully! "),
            backgroundColor: Color(0xFF64D2C2),
            duration: Duration(seconds: 2),
          ),
        );

        _controller.clear();
        setState(() {
          goalIsDone = false;
        });
        
      
        FocusScope.of(context).unfocus();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea( 
      
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _keyForm,
          child: SingleChildScrollView( 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Goal Title', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                

                CustomTextFormField(
                  controller: _controller,
                  type: 'text', 
                  label: 'Enter goal name',
                  hintText: 'e.g., Read 5 pages',
                ),
                
                SizedBox(height: 30),
                Text('Preview', style: TextStyle(color: Colors.grey)),
                

                goalItem(),
                
                SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: saveGoal, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF64D2C2),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Save Goal',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget goalItem() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 2,
            color: Colors.grey.withValues(alpha:  0.1),
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            checkColor: Colors.white,
            activeColor: Color(0xFF64D2C2),
            shape: CircleBorder(),
            value: goalIsDone,
            onChanged: (newValue) {
              setState(() {
                goalIsDone = newValue!;
              });
            },
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              _controller.text.isEmpty ? "Your goal name..." : _controller.text,
              style: TextStyle(
                fontSize: 18,
                decoration: goalIsDone ? TextDecoration.lineThrough : null,
                color: goalIsDone ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}