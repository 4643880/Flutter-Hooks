import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class CountDown extends ValueNotifier<int> {
  late StreamSubscription sub;

  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(
      const Duration(seconds: 1),
      (int myValue) => from - myValue,
    )
        .takeWhile(
      (element) => element >= 0,
    )
        .listen((event) {
      value = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountDown obj = CountDown(from: 20);
    // I don't want to create the instance again and again using memoized
    final objAgain = useMemoized(() => obj);
    final myListenable = useListenable(objAgain);
    print("Hello");

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Hooks"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(myListenable.value.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
