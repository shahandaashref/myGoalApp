import 'package:flutter/material.dart';
import 'package:goal_app/Custom/custom_text_field.dart'; 
import 'package:goal_app/Feature/Pages/model/goal_data.dart'; // تأكدي إن المسار صح
import 'package:goal_app/Feature/Pages/model/sqldb.dart';    // تأكدي إن المسار صح

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final TextEditingController _controller = TextEditingController();
  bool goalIsDone = false; 
  final GlobalKey<FormState> _keyForm = GlobalKey(); 
  
  SqlDb sqlDb = SqlDb();

  void saveGoal() async {
    if (_keyForm.currentState!.validate()) {
      // 1. تجهيز البيانات
      Goal newGoal = Goal(
        title: _controller.text,
        isDone: goalIsDone,
        date: DateTime.now().toString().split(" ")[0],
      );

      // 2. الحفظ في قاعدة البيانات
      int response = await sqlDb.insertData(newGoal);
      
      // 3. التحقق من النجاح والرجوع
      if (response > 0) {
        if (mounted) {
           // هنا بنقفل الصفحة ونبعت "true" للهوم عشان تعمل ريفرش
           // ملاحظة: شيلنا الـ SnackBar من هنا عشان يظهر في الهوم أحسن
           // وشيلنا الـ clear و setState لأن الصفحة بتتقفل خلاص
           Navigator.pop(context, true); 
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Add New Goal", style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea( 
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
                    type: "", 
                    label: 'Enter goal name',
                    hintText: 'e.g., Read 5 pages',
                    onChange: (val) {
                      setState(() {});
                    },
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