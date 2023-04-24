import 'package:flutter/material.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  bool initAnimation = false;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100), () {
      initAnimation = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedContainer(
        width: double.infinity,
        height: double.infinity,
        duration: Duration(milliseconds: 500),
        decoration: initAnimation
            ? BoxDecoration(color: Color(0xFF26282A))
            : BoxDecoration(color: Color(0xFFDDC6F9)),
      ),
    );
  }
}
