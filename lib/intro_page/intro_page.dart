import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double sizeBall = height * 0.1;
    return Scaffold(
      backgroundColor: const Color(0xFF26282A),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CookiesTitle(height: height),
          Container(
            height: sizeBall,
            width: sizeBall,
            decoration: BoxDecoration(
              color: Color(0xFFDDC6F9),
              shape: BoxShape.circle
            ),
          )
        ],
      ),
    );
  }
}

class CookiesTitle extends StatelessWidget {
  const CookiesTitle({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: height * 0.12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Cookies',
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 70.0,
              color: Color(0xFFC7FF7F),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Fresh cookies from the\noven to your home',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
