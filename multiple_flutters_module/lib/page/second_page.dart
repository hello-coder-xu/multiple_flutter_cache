import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiple_flutters_module/page/image_config.dart';

/// 第二个页面
class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int? _counter = 0;
  late MethodChannel _channel;

  // 当前图片数据
  List<Map<String, String>> get imgList {
    List<Map<String, String>> temp = List.from(marineLifeArray);
    temp.shuffle();
    return temp.take(50).toList();
  }

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
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            numberView(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    width: double.infinity,
                    height: 200,
                    imageUrl: imgList[index]['photo']!,
                  );
                },
                itemCount: imgList.length,
              ),
            ),
          ],
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
