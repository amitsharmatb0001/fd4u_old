import 'package:food_app/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/big_text.dart';
import 'package:food_app/widgets/icon_and_text_widgets.dart';
class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BigText(text: text, size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,),
        Row(
          children: [
            Wrap(
              children: List.generate(5,(index) {return Icon(Icons.star, color:AppColors.mainColor,size: 15,);}),
            ),
            SizedBox(width: 10,),
            SmallText(text: "4.5"),
            SizedBox(width: 10,),
            SmallText(text: "500"),
            SizedBox(width: 10,),
            SmallText(text: "comments")

          ],
        ),
        SizedBox(height: Dimensions.height20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconandTextWidget(icon: Icons.circle_sharp,
                text: "normal",
                iconColor: AppColors.iconColor),

            IconandTextWidget(icon: Icons.circle_sharp,
                text: "5km",
                iconColor: AppColors.mainColor),

            IconandTextWidget(icon: Icons.access_time_rounded,
                text: "25min",
                iconColor: AppColors.iconColor2)
          ],
        )
      ],
    );
  }
}
