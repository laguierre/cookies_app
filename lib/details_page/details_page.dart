import 'package:animate_do/animate_do.dart';
import 'package:cookies_app/data.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.cookie}) : super(key: key);
  final Cookies cookie;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double kSizeButton = 45.0;
    return Scaffold(
      backgroundColor: const Color(0xFF26282A),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _TopAppBar(),
            CookieFatInfo(size: size, cookie: cookie),
            const SizedBox(height: 20),
            Row(
              children: [
                BounceInLeft(
                  child: CustomCircleButton(
                      size: kSizeButton,
                      iconData: Icons.add,
                      color: kCustomPurpleColor,
                      onPressed: () {}),
                ),
                BounceInRight(child: CustomCircleButton(
                    size: kSizeButton,
                    iconData: Icons.favorite_border,
                    color: Colors.lightGreenAccent,
                    onPressed: () {}))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomCircleButton extends StatelessWidget {
  const CustomCircleButton(
      {Key? key,
      required this.size,
      required this.iconData,
      required this.color,
      required this.onPressed})
      : super(key: key);
  final double size;
  final IconData iconData;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      shape: const CircleBorder(),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(size),
        child: Icon(iconData, size: 80),
      ),
    );
  }
}

class CookieFatInfo extends StatelessWidget {
  const CookieFatInfo({
    super.key,
    required this.size,
    required this.cookie,
  });

  final Size size;
  final Cookies cookie;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: size.height * 0.10, left: 20, right: 20),
        padding: const EdgeInsets.only(bottom: 20),
        height: size.height * 0.5,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.height * 0.05),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: size.height * 0.3,
              height: size.height * 0.3,
              child: Hero(
                tag: cookie.image,
                child: Image.asset(
                  cookie.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                TextContainer(text: 'Contains eggs'),
                TextContainer(text: 'With sugar')
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                TextContainer(text: 'With Gluten'),
                TextContainer(text: 'Contains grains')
              ],
            ),
          ],
        ));
  }
}

class TextContainer extends StatelessWidget {
  const TextContainer({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 2)),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}

class _TopAppBar extends StatelessWidget {
  const _TopAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 55, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: FadeInLeft(
              child: Spin(
                spins: 1,
                child: Image.asset(
                  kBackIcon,
                  height: 50,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Spacer(),
          FadeInRight(
            child: Spin(
              spins: 1,
              child: Image.asset(
                kMenuIcon,
                height: 50,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
