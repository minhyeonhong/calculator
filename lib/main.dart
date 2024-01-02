import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int counter = 0;
  void add() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Click Count',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                    ),
                  ),
                  Text(
                    '$counter',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 100,
                    ),
                  ),
                  IconButton(
                    iconSize: 100,
                    onPressed: add,
                    icon: const Icon(Icons.add_box_outlined),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                color: Colors.white,
                child: const Column(
                  children: [
                    Text(
                      'ttt',
                      style: TextStyle(fontSize: 100),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
