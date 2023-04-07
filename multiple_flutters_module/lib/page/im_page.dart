import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// im 页面
class ImPage extends StatefulWidget {
  const ImPage({Key? key}) : super(key: key);

  @override
  State<ImPage> createState() => _ImPageState();
}

class _ImPageState extends State<ImPage> {
  List<String> img = [
    'https://img2.debug.591.com.tw/house/2020/08/19/159780089982883808.jpg!660x495.water3.s2.jpg',
    'https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i15!2i27410!3i14040!4i256!2m3!1e0!2sm!3i641379905!3m12!2szh-TW!3sUS!5e18!12m4!1e68!2m2!1sset!2sRoadmap!12m3!1e37!2m1!1ssmartmaps!4e0!23i1379903&key=AIzaSyA_T88jtygzK0sDQBqdchovUS9RcPWuP6c&token=35701',
    'https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i15!2i27410!3i14041!4i256!2m3!1e0!2sm!3i641379905!3m12!2szh-TW!3sUS!5e18!12m4!1e68!2m2!1sset!2sRoadmap!12m3!1e37!2m1!1ssmartmaps!4e0!23i1379903&key=AIzaSyA_T88jtygzK0sDQBqdchovUS9RcPWuP6c&token=59450',
    'https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i15!2i27411!3i14041!4i256!2m3!1e0!2sm!3i641379905!3m12!2szh-TW!3sUS!5e18!12m4!1e68!2m2!1sset!2sRoadmap!12m3!1e37!2m1!1ssmartmaps!4e0!23i1379903&key=AIzaSyA_T88jtygzK0sDQBqdchovUS9RcPWuP6c&token=39935',
  ];

  int? _counter = 0;
  late MethodChannel _channel;

  @override
  void initState() {
    print('flutter Im页面 initState');
    super.initState();
    _channel = const MethodChannel('multiple-flutters');
    _channel.setMethodCallHandler((call) async {
      if (call.method == "setCount") {
        _counter = call.arguments as int?;
        print('flutter im页面 _counter=$_counter');
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
    print('flutter Im页面 dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Im页面'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            cleanImageCache(),
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
    );
  }

  /// 清理图片缓存
  Widget cleanImageCache() {
    return GestureDetector(
      onTap: () {
        print('flutter im 图片清理');
        PaintingBinding.instance.imageCache.clear();
      },
      child: Container(
        width: 120,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.blue,
        ),
        child: Text('清理'),
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
