import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/Show_custom_snackbar.dart';
import '../../base/custom_loder.dart';
import '../../controllers/auth_controller.dart';
import '../../models/signup_body_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController =  TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];

    void _registration(AuthController authController)
    {

      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty)
      {
        showCustomSnackBar("type your name", title: "name");
      }
      else if(phone.isEmpty)
      {
        showCustomSnackBar("type your phone no", title: "phone no");
      }
      else if(email.isEmpty)
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
        showCustomSnackBar("successful", title: "great");
        SignUpBody  signUpBody = SignUpBody(name: name,
            phone: phone,
            email: email,
            password: password);
        print(signUpBody.toString());
        authController.registration(signUpBody).then((status)
        {
          if(status.isSuccess)
          {
            Get.offNamed(RouteHelper.getInitial());
          }
          else{
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              //App logo
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
              AppTextField(textController: emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: passwordController,
                hintText: "Password",
                icon: Icons.password, isObscure: true,),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: nameController,
                  hintText: "Name",
                  icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
              AppTextField(textController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone),
              // signup up button
              SizedBox(height: Dimensions.height20,),
              GestureDetector(
                onTap: (){
                  _registration(_authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign Up",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // sign in link
              SizedBox(height: Dimensions.height10,),
              RichText(text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text:"Have an account already?",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20
                  )
              )),
              //sign up option
              SizedBox(height: Dimensions.screenHeight*0.05,),
              RichText(text: TextSpan(
                  text:"Sign up using one of the following methods",
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16
                  )
              )),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        "assets/image/"+signUpImages[index]
                    ),
                  ),
                )),
              )
            ],
          ),
        ):const CustomLoader();
      }),
    );

  }
}
