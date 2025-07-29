import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../controllers/cart_controller.dart';
import '../../models/cart_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for(int i=0; i<getCartHistoryList.length; i++)
    {
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time))
      {
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) =>++value );
      }
      else
      {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList()
    {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList()
    {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }


    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var count=0;

    Widget timeWidget(int index)
    {
      var outputDate = DateTime.now().toString();
      if(index<getCartHistoryList.length)
      {

        DateTime parseDate =   DateFormat("yyy-MM-dd HH:mm:ss").parse(getCartHistoryList[count].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat= DateFormat("MM/dd/yyyy hh:mm a");
        outputDate= outputFormat.format(inputDate);
      }
      return BigText(text: outputDate,);
    }


    return Scaffold
      (
      body: Column
        (
        children:
        [ //header or app bar
          Container(
            height: Dimensions.height10*10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(text:"   Cart History",color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart, iconColor: Colors.white, backgroundColor: AppColors.mainColor,)
              ],
            ),
          ),
          //body
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().isNotEmpty?Expanded(child: Container(
                margin: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context, child: ListView
                  (
                  children:
                  [
                    for(int i=0; i<itemsPerOrder.length; i++)
                      Container(
                        height: Dimensions.height30*4,
                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            timeWidget(count),
                            SizedBox(height: Dimensions.height10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(itemsPerOrder[i], (index)
                                  {
                                    if(count<getCartHistoryList.length)
                                    {
                                      count ++;
                                    }
                                    return index<=2?Container(
                                      height: Dimensions.height20*4,
                                      width: Dimensions.height20*4,
                                      margin: EdgeInsets.only(right: Dimensions.width10/2),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[count-1].img!
                                              )
                                          )
                                      ),

                                    ):Container();
                                  }),
                                ),
                                Container(
                                  height: Dimensions.height20*4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SmallText(text:"total",color: AppColors.titleColor,),
                                      BigText(text: itemsPerOrder[i].toString()+ "items ",color: AppColors.titleColor,),
                                      GestureDetector(
                                        onTap:()
                                        {
                                          var orderTime = cartOrderTimeToList();
                                          Map<int, CartModel> moreOrder ={};
                                          for(int j=0; j<getCartHistoryList.length; j++)
                                          {
                                            if(getCartHistoryList[j].time==orderTime[i])
                                            {
                                              moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                  CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))

                                              );
                                            }
                                          }
                                          Get.find<CartController>().setItems = moreOrder;
                                          Get.find<CartController>().addToCartList();
                                          Get.toNamed(RouteHelper.getCartPage());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,
                                              vertical: Dimensions.height10/2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                            border: Border.all(width: 1, color: AppColors.mainColor),
                                          ),
                                          child: SmallText(text: "fuyg",color: AppColors.mainColor,),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                      )
                  ],
                ),)
            )):NoDataPage(text:"your history is empty");
          })
        ],
      ),
    );
  }
}
