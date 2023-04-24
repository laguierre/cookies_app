import 'package:cookies_app/catalog_page/catalog_page.dart';
import 'package:cookies_app/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marqueer/marqueer.dart';
import 'package:rive/rive.dart';
import 'dart:math' as math;

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  late AnimationController mainController;
  late Animation<double> mainAnimation;

  bool isBouncing = false;

  //late RiveAnimationController riveController;

  @override
  void initState() {
    super.initState();
    mainController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    mainAnimation = Tween<double>(begin: 0, end: 2).animate(CurvedAnimation(
      parent: mainController,
      curve: Curves.linear,
    ))
      ..addListener(() {
        if(mainAnimation.isCompleted){
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => CatalogPage()), (route) => false);
        }
        setState(() {});
      });
    Future.delayed(const Duration(milliseconds: 4000), () {
      isBouncing = true;
      mainController.forward();
      setState(() {});
    });
    /*riveController = OneShotAnimation(
      'bounce',
      autoplay: true
    );*/
  }

  @override
  void dispose() {
    mainController.dispose();
    //riveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double fontFreshCookies = 75;
    double value = mainAnimation.value;
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFF26282A),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CookiesTitle(height: height),
          const RiveAnimation.asset(
            'lib/assets/rives/bouncing.riv',
            fit: BoxFit.fitHeight,
          ),
          if (isBouncing)
            FreshCookiesTextMarquee(
                width: width,
                height: height,
                mainAnimation: mainAnimation,
                fontFreshCookies: fontFreshCookies),
          Positioned(
            top: height / 2 + 100,
            bottom: 40,
            left: value <= 1? 140 * mainAnimation.value - 250 : value >= 1? 140 * (2-mainAnimation.value) - 250 : 90,
            width: width * 0.55,
            child: Transform.rotate(
                angle: -2 * math.pi * mainAnimation.value,
                child: Image.asset(cookies[0]['image']!)),
          ),
          Positioned(
            top: height * 0.25,
            bottom: 30,
            right: value <= 1? 140 * mainAnimation.value - 250 : 140 * (2-mainAnimation.value) - 250,
            width: width * 0.6,
            child: Transform.rotate(
                angle: 2 * math.pi * mainAnimation.value,
                child: Image.asset(cookies[2]['image']!)),
          )
        ],
      ),
    );
  }
}

class FreshCookiesTextMarquee extends StatelessWidget {
  const FreshCookiesTextMarquee({
    super.key,
    required this.width,
    required this.height,
    required this.mainAnimation,
    required this.fontFreshCookies,
  });

  final double width;
  final double height;
  final Animation<double> mainAnimation;
  final double fontFreshCookies;

  @override
  Widget build(BuildContext context) {
    double value = mainAnimation.value;
    return Positioned(
      width: width,
      top: height / 2 + 55,
      bottom: 10,
      child: Opacity(
        opacity: value <= 1
            ? (mainAnimation.value).clamp(0, 1)
            : (2 - mainAnimation.value).clamp(0, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Marqueer(
                direction: MarqueerDirection.rtl,
                child: Text(
                  'Fresh cookies ',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      color: const Color(0xFFE9D8FC),
                      fontSize: fontFreshCookies),
                ),
              ),
            ),
            Expanded(
                child: Marqueer(
              direction: MarqueerDirection.ltr,
              child: Text(
                'Fresh cookies ',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: const Color(0xFFE9D8FC),
                    fontSize: fontFreshCookies),
              ),
            )),
            Expanded(
                child: Marqueer(
              direction: MarqueerDirection.rtl,
              child: Text(
                'Fresh cookies ',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: const Color(0xFFE9D8FC),
                    fontSize: fontFreshCookies),
              ),
            )),
          ],
        ),
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
