import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart'; // for date format
import 'package:intl/date_symbol_data_local.dart'; // for other locales

void main() {
  runApp(const MyApp());
}

extension CompactMap<T> on Iterable<T?> {}

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

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<String> fetchData() async {
      await Future.delayed(const Duration(seconds: 5));
      return "Hello Aizaz";
    }

    final myFuture = fetchData();
    final myFutureHook = useFuture(myFuture);

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
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Text("Result will be display after 10 seconds"),
              ),
              (myFutureHook.hasData)
                  ? Text(
                      myFutureHook.data.toString(),
                      style: Theme.of(context).textTheme.headline5,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
