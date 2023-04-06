import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiple_flutters_module/page/first_page.dart';
import 'package:multiple_flutters_module/page/im_page.dart';
import 'package:multiple_flutters_module/page/second_page.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

String get defaultRouteName => window.defaultRouteName;

void main() {
  runApp(const MyApp(
    color: Colors.blue,
    from: 'main',
  ));
}

@pragma('vm:entry-point')
void topMain() {
  runApp(const MyApp(
    color: Colors.green,
    from: 'topMain',
  ));
}

@pragma('vm:entry-point')
void bottomMain() {
  runApp(const MyApp(
    color: Colors.purple,
    from: 'bottomMain',
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.color,
    required this.from,
  });

  final MaterialColor color;
  final String from;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter测试demo',
      theme: ThemeData(
        colorSchemeSeed: color,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 8,
        ),
      ),
      home: getPage(),
    );
  }

  /// 获取页面
  Widget getPage() {
    print('test $from defaultRouteName=$defaultRouteName');
    switch (defaultRouteName) {
      case '/first':
        return FirstPage();
      case '/second':
        return SecondPage();
      case '/im':
        return ImPage();
      default:
        return MyHomePage();
    }
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? _counter = 0;
  late MethodChannel _channel;

  @override
  void initState() {
    super.initState();
    _channel = const MethodChannel('multiple-flutters');
    _channel.setMethodCallHandler((call) async {
      if (call.method == "setCount") {
        // A notification that the host platform's data model has been updated.
        setState(() {
          _counter = call.arguments as int?;
        });
      } else {
        throw Exception('not implemented ${call.method}');
      }
    });
  }

  void _incrementCounter() {
    _channel.invokeMethod<void>("incrementCount", _counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('默认页面'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '你已经按了这么多次按钮:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextButton(
              onPressed: _incrementCounter,
              child: const Text('数量增加'),
            ),
            TextButton(
              onPressed: () {
                _channel.invokeMethod<void>("next", _counter);
              },
              child: const Text('下一个页面'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Use the url_launcher plugin to open the Flutter docs in
                // a browser.
                final url = Uri.parse('https://flutter.dev/docs');
                if (await launcher.canLaunchUrl(url)) {
                  await launcher.launchUrl(url);
                }
              },
              child: const Text('Open Flutter Docs'),
            ),
          ],
        ),
      ),
    );
  }
}
