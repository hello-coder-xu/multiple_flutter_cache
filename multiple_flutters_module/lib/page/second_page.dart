import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 第二个页面
class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<String> img = [
    'https://img2.debug.591.com.tw/house/2022/05/17/165276672790429100.jpeg!224x168.s2.jpeg',
    'https://img1.debug.591.com.tw/house/2022/03/08/164673870690035401.jpg!224x168.s2.jpg',
    'https://img2.debug.591.com.tw/house/2022/03/08/164673879498723905.jpg!224x168.s2.jpg',
    'https://img2.debug.591.com.tw/house/2021/11/18/163722321043101907.jpg!224x168.s2.jpg',
    'https://img2.debug.591.com.tw/house/2022/01/17/164241745963461004.jpg!224x168.s2.jpg',
  ];

  int? _counter = 0;
  late MethodChannel _channel;

  @override
  void initState() {
    print('flutter 第二个 initState');
    super.initState();
    _channel = const MethodChannel('multiple-flutters');
    _channel.setMethodCallHandler((call) async {
      if (call.method == "setCount") {
        _counter = call.arguments as int?;
        print('flutter 第二个 _counter=$_counter');
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
    print('flutter 第二个 dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第二个页面'),
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
