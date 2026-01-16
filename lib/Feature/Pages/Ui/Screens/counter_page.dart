import 'package:flutter/material.dart';
import 'package:goal_app/Providers/colormode.dart';
import 'package:goal_app/Providers/counter_provder.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('cont'),
            //Text('${context.watch<CounterProvder>().counter}'),
            ElevatedButton(
              onPressed: () {
                context.read<CounterProvder>().decrement();
              },
              child: Text('decrement'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //context.read<CounterProvder>().increment();
          //context.read<Colormode>().thememode();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
