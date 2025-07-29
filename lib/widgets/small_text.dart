import 'package:flutter/cupertino.dart';
import '../utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  // Add these two new properties to the widget
  final int? maxLines;
  final TextOverflow? overflow;

  SmallText({
    Key? key,
    this.color = const Color(0xff2972ff),
    required this.text,
    this.size = 0,
    this.height = 0,
    // Include them in the constructor
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // Pass the new properties to the Text widget
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: color,
        fontSize: size == 0 ? Dimensions.font12 : size,
        // Corrected the logic to use the height parameter
        height: height == 0 ? 1.2 : height,
      ),
    );
  }
}
