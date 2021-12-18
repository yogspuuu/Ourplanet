import 'dart:math' as math;
import 'package:ourplanet/data.dart';
import 'package:flutter/material.dart';

class PlanetItem extends StatefulWidget {
  final int index;

  const PlanetItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _PlanetItemState createState() => _PlanetItemState();
}

class _PlanetItemState extends State<PlanetItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 30000,
      ),
    );
    _controller.forward();
    _controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'image' + widget.index.toString(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (ctx, child) {
          return Transform.rotate(
            angle: math.pi * _controller.value * 2,
            child: child,
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.width * 0.8,
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Image.asset(
            PlanetData.planets[widget.index].image,
          ),
        ),
      ),
    );
  }
}
