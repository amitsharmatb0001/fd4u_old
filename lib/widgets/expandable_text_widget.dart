import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;

  // The number of lines to show when the text is collapsed.
  // You can change this value to 1, 3, etc. as you see fit.
  final int collapsedLineCount = 5;

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder provides the constraints of the parent widget, which allows
    // us to accurately measure the text layout.
    return LayoutBuilder(
      builder: (context, constraints) {
        // We use a TextPainter to determine if the text will exceed the
        // collapsed line count within the available width.
        final textSpan = TextSpan(
          text: widget.text,
          style: TextStyle(
            fontSize: Dimensions.font16,
            // This style should match the style used in your SmallText widget.
          ),
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: collapsedLineCount,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);

        // This boolean tells us if the text is long enough to need a "Show more" button.
        final bool isTextOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // This now correctly passes maxLines and overflow to your updated SmallText widget.
            SmallText(
              text: widget.text,
              // Conditionally change the color based on the expanded state.
              // Assuming you have another color like 'AppColors.titleColor' or similar for the expanded text.
              color: isExpanded ? AppColors.paraColor : AppColors.mainColor,
              size: Dimensions.font16,
              height: 1.8,
              // We conditionally set maxLines to control the collapsed/expanded state.
              maxLines: isExpanded ? null : collapsedLineCount,
              // Use ellipsis to indicate that the text is truncated.
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),

            // The "Show more/less" button is only shown if the text is overflowing.
            if (isTextOverflowing)
              InkWell(
                // Use a transparent splash color for a cleaner tap effect.
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      SmallText(
                        text: isExpanded ? "Show less" : "Show more",
                        color: AppColors.mainColor,
                        size: Dimensions.font16,
                      ),
                      Icon(
                        isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: AppColors.mainColor,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
