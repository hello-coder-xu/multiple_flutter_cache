import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Im页面'),
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
