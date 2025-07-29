


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/popular_product_repo.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../utils/colors.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<ProductModel> _popularProductList=[];
  List<ProductModel> get popularProductList =>_popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded=>_isLoaded;

  //cart variable

  int _quantity=0;
  int get quantity=>_quantity;
  int _inCartItems=0;
  int get inCartItems=>_inCartItems+_quantity;

  Future<void> getPopularProductList()async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded=true;
      update();
    }
    else
    {
      print("data not found");

    }
  }

  void setQuantity(bool isIncrement)
  {
    if(isIncrement)
    {
      _quantity=checkQuantity(_quantity+1);
    }
    else
    {
      _quantity=checkQuantity(_quantity-1);
    }
    update();
  }

  int checkQuantity(int quantity)
  {
    if((_inCartItems+quantity)<0)
    {
      Get.snackbar("Item count","you can't reduce more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems>0)
      {
        _quantity=-_inCartItems;

        return _quantity;
      }
      return 0;
    }
    else if((_inCartItems+quantity)>20)
    {
      Get.snackbar("Item count","you can't add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    }
    else
    {
      return quantity;
    }

  }

  void initProduct(ProductModel product,CartController cart)
  {
    _quantity=0;
    _inCartItems=0;
    _cart=cart;
    var exist=false;
    exist = _cart.existInCart(product);
    //if exits
    //get from storage _inCartItems=3
    if(exist)
    {
      _inCartItems=cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product)
  {
    if(_quantity>0)
    {
      _cart.addItem(product, _quantity);

      _quantity=0;
      _inCartItems=_cart.getQuantity(product);

    }
    update();

  }


  int get totalItems
  {
    return _cart.totalItems;
  }

  List<CartModel> get getItems
  {
    return _cart.getItems;
  }
}
