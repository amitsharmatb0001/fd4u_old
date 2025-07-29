

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/custom_loder.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().Userloggedin();
    if(_userLoggedIn)
    {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile", size: 24, color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?(userController.isLoading?Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              //profile icon
              AppIcon(icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height45+Dimensions.height30,
                size: Dimensions.height15*10,
              ),
              SizedBox(height: Dimensions.height30,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //name
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.person,
                            backgroundColor: Colors.blue,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ),
                          bigText: BigText(text: userController.userModel.name,)
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //mobile no
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.phone,
                            backgroundColor: Colors.blue,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ),
                          bigText: BigText(text: userController.userModel.phone,)
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //email
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.email,
                            backgroundColor: Colors.blue,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ),
                          bigText: BigText(text: userController.userModel.email,)
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //address
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.location_on,
                            backgroundColor: Colors.blue,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ),
                          bigText: BigText(text: "swift college",)
                      ),
                      SizedBox(height: Dimensions.height20,),
                      //message
                      AccountWidget(
                          appIcon: AppIcon(icon: Icons.message,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize: Dimensions.height10*5/2,
                            size: Dimensions.height10*5,
                          ),
                          bigText: BigText(text: "Messages",)
                      ),
                      SizedBox(height: Dimensions.height20,),
                      GestureDetector(
                        onTap: () {
                          if (Get.find<AuthController>().Userloggedin()) {
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.offNamed(RouteHelper.getSignInPage());
                          }
                        },
                        child: AccountWidget(
                            appIcon: AppIcon(icon: Icons.logout,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10*5/2,
                              size: Dimensions.height10*5,
                            ),
                            bigText: BigText(text: "Logout",)
                        ),
                      ),
                      SizedBox(height: Dimensions.height20,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ):
        CustomLoader()):
        Container(child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: Dimensions.height20*8,
              margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/image/signin.png"
                      )
                  )
              ),
            ),
            GestureDetector(
              onTap: ()
              {
                Get.toNamed(RouteHelper.getSignInPage());
              },

              child: Container(
                width: double.maxFinite,
                height: Dimensions.height20*5,
                margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: Center(child: BigText(text:"Sign In", color: Colors.white,size:  Dimensions.font26,)),
              ),
            )
          ],
        )
        ));
      }),
    );
  }
}
