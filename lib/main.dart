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

const imageUrl =
    "https://cdn.pixabay.com/photo/2022/09/13/17/02/leaves-7452420_960_720.jpg";

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rotation = 0;

    late final StreamController<double> controller;
    controller = useStreamController<double>(
      onListen: () {
        controller.sink.add(0.0);
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Hooks"),
      ),
      body: StreamBuilder(
        stream: controller.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            rotation = snapshot.data ?? 0;
            return GestureDetector(
              onTap: () {
                controller.sink.add(rotation + 30);
              },
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(rotation / 360),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Image(
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
