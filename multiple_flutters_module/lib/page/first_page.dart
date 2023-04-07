import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

/// 第一个页面
class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<String> img = [
    'https://img2.debug.591.com.tw/house/2020/08/19/159780089982883808.jpg!660x495.water3.s2.jpg',
    'https://img1.debug.591.com.tw/house/2020/11/05/160455568657854409.jpg!224x168.s2.jpg',
    'https://img2.debug.591.com.tw/house/2022/03/08/164673868978349805.jpg!224x168.s2.jpg',
    'https://img1.debug.591.com.tw/house/2022/03/08/164673867449756808.jpg!224x168.s2.jpg',
  ];

  int? _counter = 0;
  late MethodChannel _channel;

  @override
  void initState() {
    print('flutter 第一个 initState');
    super.initState();
    _channel = const MethodChannel('multiple-flutters');
    _channel.setMethodCallHandler((call) async {
      if (call.method == "setCount") {
        _counter = call.arguments as int?;
        print('flutter 第一个 _counter=$_counter');
        setState(() {});
      } else {
        throw Exception('not implemented ${call.method}');
      }
    });
  }

  void _incrementCounter() {
    _channel.invokeMethod<void>("incrementCount", _counter);
  }

  @override
  void dispose() {
    print('flutter 第一个 dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一个页面'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              numberView(),
              ...img.map((e) {
                return CachedNetworkImage(
                  width: 100,
                  height: 100,
                  imageUrl: e,
                );
              }).toList(),

            ],
          ),
        ),
      ),
    );
  }



  /// 数量视图
  Widget numberView() {
    return Column(
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
      ],
    );
  }
}
