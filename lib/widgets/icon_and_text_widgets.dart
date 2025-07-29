import 'package:food_app/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import "package:food_app/widgets/small_text.dart";

class IconandTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const IconandTextWidget({Key? key,
    required this.icon,
    required this.text,
    required this.iconColor,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Icon(icon, color: iconColor, size: Dimensions.icon24),
        SizedBox(width: 5,),
        SmallText(text: text,),
      ],
    );
  }
}
