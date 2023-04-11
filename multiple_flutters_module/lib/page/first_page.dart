import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:multiple_flutters_module/page/image_config.dart';

/// 第一个页面
class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int? _counter = 0;
  late MethodChannel _channel;

  // 当前图片数据
  List<Map<String, String>> get imgList {
    // List<Map<String, String>> temp = List.from(marineLifeArray);
    // temp.shuffle();
    // return temp.take(50).toList();
    return marineLifeArray;
  }

  ImageCache get imageCache => PaintingBinding.instance.imageCache;

  // 缓存图片数量
  int get imageCacheCount => imageCache.currentSize;

  // 缓存图片大小
  int get imageCacheSizeBytes =>
      PaintingBinding.instance.imageCache.currentSizeBytes;

  // 缓存图片大小值(M)
  String get imageCacheSizeBytesValue =>
      '${imageCacheSizeBytes / 1024 / 1024}M';

  @override
  void initState() {
    print('flutter 第一个 initState');
    super.initState();
    print('flutter 第一个 进入 缓存图片数量：$imageCacheCount');
    print('flutter 第一个 进入 缓存图片大小：$imageCacheSizeBytes');
    print('flutter 第一个 进入 缓存图片大小值：$imageCacheSizeBytesValue');
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
    print('flutter 第一个 退出 缓存图片数量：$imageCacheCount');
    print('flutter 第一个 退出 缓存图片大小：$imageCacheSizeBytes');
    print('flutter 第一个 退出 缓存图片大小值：$imageCacheSizeBytesValue');
    imageCache.clear();
    imageCache.clearLiveImages();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一个页面'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_outlined,
            size: 24,
          ),
        ),
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
