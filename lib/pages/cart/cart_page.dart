import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base/no_data_page.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
        body: Stack(
          children: [
            //header
            Positioned(
                top: Dimensions.height20*2,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row
                  ( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize:Dimensions.icon24,
                    ),
                    SizedBox(width: Dimensions.width20*5,),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(icon: Icons.home_max_rounded,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize:Dimensions.icon24,
                      ),
                    ),

                    AppIcon(icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize:Dimensions.icon24,
                    ),
                  ],
                )),
            //body
            GetBuilder<CartController>(builder: (cartController){
              return cartController.getItems.isNotEmpty?Positioned(
                  top:Dimensions.height20*5,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  bottom: 0,
                  child: Container
                    (
                    margin: EdgeInsets.only(top: Dimensions.height15),
                    // color: Colors.redAccent,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (cartController){
                        var _cartlist=cartController.getItems;
                        return ListView.builder(
                            itemCount: _cartlist.length,
                            itemBuilder: (_, index){
                              return Container(
                                width: double.maxFinite,
                                height: Dimensions.height20*5,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                        onTap: ()
                                        {
                                          var popularIndex = Get.find<PopularProductController>
                                            ().popularProductList
                                              .indexOf(_cartlist[index].product!);

                                          if(popularIndex>=0)
                                          {
                                          }
                                          else
                                          {
                                            var recommendedIndex = Get.find<RecommendedProductController>
                                              ().recommendedProductList
                                                .indexOf(_cartlist[index].product!);
                                            if(recommendedIndex<0)
                                            {
                                              Get.snackbar("historyProduct", "Product review is not available for history product",
                                                backgroundColor: AppColors.mainColor,
                                                colorText: Colors.white,
                                              );


                                            }
                                            else
                                            {
                                              Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cart page"));
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: Dimensions.height20*5,
                                          height: Dimensions.height20*5,
                                          decoration: BoxDecoration(
                                              image:DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                                  )
                                              ),
                                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              color: Colors.white
                                          ),
                                        )
                                    ),
                                    Expanded(child: Container(
                                      height: Dimensions.height20*5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(text: cartController.getItems[index].name!, color: Colors.black,),
                                          //SmallText(text: "gjgf"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text: cartController.getItems[index].price.toString()),


                                              Container(
                                                padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,left: Dimensions.width10,right: Dimensions.width20),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                    color: Colors.white
                                                ),
                                                child: Row(

                                                  children: [
                                                    GestureDetector(
                                                        onTap: (){
                                                          cartController.addItem(_cartlist[index].product!,-1);
                                                        },

                                                        child: Icon(Icons.remove, color: Colors.black,)),
                                                    SizedBox(width: Dimensions.width10/2,),
                                                    BigText(text: _cartlist[index].quantity.toString()),//popularProduct.inCartItems.toString()),
                                                    SizedBox(width: Dimensions.width10/2,),
                                                    GestureDetector(
                                                        onTap: (){
                                                          cartController.addItem(_cartlist[index].product!,1);
                                                        },
                                                        child: Icon(Icons.add, color: Colors.black,)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),);
                            });
                      }),
                    ),
                  )):NoDataPage(text:"your cart is empty" );
              // return _cartController.getItems.isNotEmpty?Positioned(
              //                 top:Dimensions.height20*5,
              //                 left: Dimensions.width20,
              //                 right: Dimensions.width20,
              //                 bottom: 0,
              //                 child: Container
              //                   (
              //                   margin: EdgeInsets.only(top: Dimensions.height15),
              //                   color: Colors.redAccent,
              //                   child: MediaQuery.removePadding(
              //                     context: context,
              //                     removeTop: true,
              //                     child: GetBuilder<CartController>(builder: (cartController){
              //                       var _cartlist=cartController.getItems;
              //                       return ListView.builder(
              //                           itemCount: _cartlist.length,
              //                           itemBuilder: (_, index){
              //                             return Container(
              //                               width: double.maxFinite,
              //                               height: Dimensions.height20*5,
              //                               child: Row(
              //                                 children: [
              //                                   GestureDetector(
              //                                       onTap: ()
              //                                       {
              //                                         var popularIndex = Get.find<PopularProductController>
              //                                           ().popularProductList
              //                                             .indexOf(_cartlist[index].product!);
              //
              //                                         if(popularIndex>=0)
              //                                         {
              //                                         }
              //                                         else
              //                                         {
              //                                           var recommendedIndex = Get.find<RecommendedProductController>
              //                                             ().recommendedProductList
              //                                               .indexOf(_cartlist[index].product!);
              //                                           if(recommendedIndex<0)
              //                                           {
              //                                             Get.snackbar("historyProduct", "Product review is not available for history product",
              //                                               backgroundColor: AppColors.mainColor,
              //                                               colorText: Colors.white,
              //                                             );
              //
              //
              //                                           }
              //                                           else
              //                                           {
              //                                             Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cart page"));
              //                                           }
              //                                         }
              //                                       },
              //                                       child: Container(
              //                                         width: Dimensions.height20*5,
              //                                         height: Dimensions.height20*5,
              //                                         decoration: BoxDecoration(
              //                                             image:DecorationImage(
              //                                                 fit: BoxFit.cover,
              //                                                 image: NetworkImage(
              //                                                     AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
              //                                                 )
              //                                             ),
              //                                             borderRadius: BorderRadius.circular(Dimensions.radius20),
              //                                             color: Colors.white
              //                                         ),
              //                                       )
              //                                   ),
              //                                   Expanded(child: Container(
              //                                     height: Dimensions.height20*5,
              //                                     child: Column(
              //                                       crossAxisAlignment: CrossAxisAlignment.start,
              //                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //                                       children: [
              //                                         BigText(text: cartController.getItems[index].name!, color: Colors.black,),
              //                                         SmallText(text: "gjgf"),
              //                                         Row(
              //                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                                           children: [
              //                                             BigText(text: cartController.getItems[index].price.toString()),
              //
              //
              //                                             Container(
              //                                               padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,left: Dimensions.width10,right: Dimensions.width20),
              //                                               decoration: BoxDecoration(
              //                                                   borderRadius: BorderRadius.circular(Dimensions.radius20),
              //                                                   color: Colors.white
              //                                               ),
              //                                               child: Row(
              //
              //                                                 children: [
              //                                                   GestureDetector(
              //                                                       onTap: (){
              //                                                         cartController.addItem(_cartlist[index].product!,-1);
              //                                                       },
              //
              //                                                       child: Icon(Icons.remove, color: AppColors.signColor,)),
              //                                                   SizedBox(width: Dimensions.width10/2,),
              //                                                   BigText(text: _cartlist[index].quantity.toString()),//popularProduct.inCartItems.toString()),
              //                                                   SizedBox(width: Dimensions.width10/2,),
              //                                                   GestureDetector(
              //                                                       onTap: (){
              //                                                         cartController.addItem(_cartlist[index].product!,1);
              //                                                       },
              //                                                       child: Icon(Icons.add, color: AppColors.signColor,)),
              //                                                 ],
              //                                               ),
              //                                             )
              //                                           ],
              //                                         )
              //                                       ],
              //                                     ),
              //                                   ))
              //                                 ],
              //                               ),);
              //                           });
              //                     }),
              //                   ),
              //                 )):const NoDataPage(text:"your cart is empty" );
            })
          ],
        ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2)
                )
            ),
            child: cartController.getItems.isNotEmpty?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white
                  ),
                  child: Row(
                    children: [

                      SizedBox(width: Dimensions.width10/2,),
                      BigText(text: "\₹ "+cartController.totalAmount.toString()),
                      SizedBox(width: Dimensions.width10/2,),

                    ],
                  ),
                ),
                GestureDetector
                  (
                  onTap: ()
                  {
                    if(Get.find<AuthController>().Userloggedin())
                    {
                      cartController.addToHistory();

                    }
                    else{
                      Get.toNamed(RouteHelper.getSignInPage());
                    }

                    //popularProduct.addItem(product);
                    //  cartController.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                    child: BigText(text: "check out", color: Colors.white,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor
                    ),
                  ),
                )
              ],
            ):Container(),
          );
        },)

    );
  }
}
