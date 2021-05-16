import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {@required this.colour, this.cardChild, this.onPress, this.height});

  final Color colour;
  final Widget cardChild;
  final Function onPress;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: height,
          child: cardChild,
          // margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
