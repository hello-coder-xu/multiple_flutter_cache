import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一个页面'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: img.map((e) {
            return CachedNetworkImage(
              width: 100,
              height: 100,
              imageUrl: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
