import 'dart:math' as math;
import 'package:ourplanet/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  final double bgPosition;

  const DetailScreen({
    Key? key,
    required this.index,
    required this.bgPosition,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controllerPosition;

  void start() async {
    await Future.delayed(
      const Duration(
        milliseconds: 500,
      ),
    );

    _controllerPosition.forward();
    _controller.forward();
    _controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerPosition.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controllerPosition = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 30000,
      ),
    );

    start();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double planetPosition() {
      return (_controllerPosition.value * size.height * 0.5);
    }

    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              right: widget.bgPosition,
              child: Hero(
                tag: 'bg' + widget.index.toString(),
                child: SizedBox(
                  height: size.height * 1.5,
                  child: Image.asset(
                    'assets/bg.png',
                    alignment: Alignment.center,
                    height: size.height * 1.5,
                    width: size.width * 3.5,
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (ctx, child) {
                return Transform.translate(
                  offset: Offset(0, planetPosition()),
                  child: Transform.rotate(
                    angle: math.pi * _controller.value * 2,
                    child: Hero(
                      tag: 'image' + widget.index.toString(),
                      child: Image.asset(
                        PlanetData.planets[widget.index].image,
                        width: size.width,
                        height: size.width,
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 12,
                right: 12,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FadeIn(
                      duration: const Duration(milliseconds: 1),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: size.width / 8,
                          width: size.width / 8,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(24)),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.back,
                              color: Colors.white,
                              size: size.width / 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setSp(24),
                    ),
                    FadeIn(
                      duration: const Duration(seconds: 1),
                      child: Text(
                        PlanetData.planets[widget.index].name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(24),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setSp(24),
                    ),
                    FadeIn(
                      duration: const Duration(seconds: 1),
                      child: Text(
                        PlanetData.planets[widget.index].data,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setSp(24),
                    ),
                    FadeIn(
                      duration: const Duration(seconds: 1),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Mass : ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            PlanetData.planets[widget.index].mass,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    FadeIn(
                      duration: const Duration(seconds: 1),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Radius : ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            PlanetData.planets[widget.index].radius,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    FadeIn(
                      duration: const Duration(seconds: 1),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Orbital Period : ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            PlanetData.planets[widget.index].orbitalPeriod,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
