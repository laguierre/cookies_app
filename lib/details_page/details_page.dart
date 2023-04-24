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
    return Scaffold(
      backgroundColor: const Color(0xFF26282A),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 65, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _TopAppBar(),
            Container(
                margin: EdgeInsets.only(top: size.height * 0.15),
                height: size.height * 0.5,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.height * 0.08),
                    color: Colors.white)),
          ],
        ),
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
    return Row(
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
    );
  }
}
