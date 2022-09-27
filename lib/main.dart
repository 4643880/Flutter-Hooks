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
    final count = useState(0);
    count.value++;

    Future<String> fetchData() async {
      await Future.delayed(const Duration(seconds: 3));
      return "Hello Aizaz ${count.value}";
    }

    // We use it for Caching the data that came from future first time will remain same
    final myMemoizedHook = useMemoized(fetchData);
    final myFutureHook = useFuture(myMemoizedHook);

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
