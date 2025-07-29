import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_app/pages/auth/sign.dart';
import 'package:get/get.dart';

import '../../base/Show_custom_snackbar.dart';
import '../../base/custom_loder.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController =  TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController)
    {


      String email = emailController.text.trim();
      String password = passwordController.text.trim();


      if(email.isEmpty)
      {
        showCustomSnackBar("type your email", title: "email");
      }
      else if(!GetUtils.isEmail(email))
      {
        showCustomSnackBar("type a valid email", title: "valid email");
      }
      else if(password.isEmpty)
      {
        showCustomSnackBar("type your password", title: "password");
      }
      else if(password.length<6)
      {
        showCustomSnackBar("your password do not meet the criteria", title: "no valid");
      }
      else
      {

        authController.login(email, password).then((status)
        {
          if(status.isSuccess)
          {
            Get.offNamed(RouteHelper.getCartPage());
          }
          else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body:GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/image/logo.png"
                    ),
                  ),
                ),
              ),
              //welcome section
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20*3+Dimensions.font20/2,
                          fontWeight: FontWeight.bold
                      ),

                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          //fontWeight: FontWeight.bold
                          color: Colors.grey[500]
                      ),

                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: passwordController,
                hintText: "Password",
                icon: Icons.password, isObscure:true,),
              SizedBox(height: Dimensions.height10,),
              // sign in link
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(text: TextSpan(
                      text:"Sign into your account",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      )
                  )),
                  SizedBox(width: Dimensions.width20,)
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              GestureDetector(
                onTap: ()
                {
                  _login(authController);
                },

                child: Container(
                  width: Dimensions.screenHeight/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign In",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //sign up option
              RichText(text: TextSpan(
                  text:"Don\'t have an account?",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16
                  ),

                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>Sign(), transition: Transition.fade),
                        text:" Create",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainBlackColor,
                            fontSize: Dimensions.font16
                        )),

                  ]
              )),

            ],
          ),
        ):CustomLoader();
      }),
    );
  }
}
