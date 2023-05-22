import 'package:ShopApp/Lay_out/Cubit/cubit.dart';
import 'package:ShopApp/Lay_out/Cubit/states.dart';
import 'package:ShopApp/Lay_out/home_layout.dart';
import 'package:ShopApp/Shareing/Compounant/compunant.dart';
import 'package:ShopApp/models/CartModel.dart';
import 'package:ShopApp/moduls/ChackOut.dart';
import 'package:ShopApp/moduls/home_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState(){
    BlocProvider.of<ShopCubit>(context).getCart();
    BlocProvider.of<ShopCubit>(context).getFavorite();
    BlocProvider.of<ShopCubit>(context).getUser();

  }
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: Container(

              //
              height: 120,
              // margin: EdgeInsets.all(20.0),

              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20.0),
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27),
                      color: Colors.grey[300],

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Text(
                              'Total Price:',
                              style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                              ),

                            ),
                          ),
                          Text(
                            '${cubit.cartModel!.data!.total.toString()} EGP',
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: Container(
                  //     height: 47,
                  //     width: double.infinity,
                  //     // width: 13,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(25)
                  //     ),
                  //
                  //     child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           backgroundColor: Colors.orangeAccent),
                  //       child: Text(
                  //         'Go To Shopping',
                  //         style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 17,
                  //             fontWeight: FontWeight.w400),
                  //       ),
                  //       onPressed: () {
                  //         navigateTo(context,Home_Layout());
                  //       },
                  //     ),
                  //   ),
                  // ),

                ],
              ),
            ),
            elevation: 6,
            color: Colors.white,
          ),

          body: ConditionalBuilder(
            condition: state is! ShopLoadingCartState&&ShopCubit.get(context).carts.length<1,
              fallback: (context) => Center(
                child: CircularProgressIndicator(
              color: Colors.orangeAccent,
            )),
            builder: (context) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildCart(
                    ShopCubit.get(context).cartModel!.data!.cartItems[index],
                    context,index),
                separatorBuilder: (context, index) => dividerWidget(),
                itemCount:
                    ShopCubit.get(context).cartModel!.data!.cartItems.length,
              );
            },
          ),
        );
      },
    );
  }
}

Widget buildCart(CartItems? model, context , index) => Padding(

      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 100,
                  height: 100,
                  child: CachedNetworkImage(
                      imageUrl: '${model!.product!.image!}',
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return Icon(
                          Icons.error,
                        );
                      },
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                color: Colors.orangeAccent,
                                value: downloadProgress.progress,
                                strokeWidth: 3,
                              )))),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product!.name!.toUpperCase()}',
                      maxLines: 2,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Text(
                      '${model.product!.price!} EGP',
                      maxLines: 2,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: (){
                    ShopCubit.get(context).changCart(productId:model.product!.id);
                    print(model.id);
                  }, icon: Icon(
                    Icons.delete,
                    color: Colors.orangeAccent,
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                        ) ,
                        onPressed: () {
                          int quantity = model.quantity-1;
                          if(quantity != 0)
                            ShopCubit.get(context).updateCart(model.id, quantity);


                        },
                      ),
                      SizedBox(
                        width: 9,
                      ),
                      Text(
                        '${model.quantity}',
                        style: TextStyle(
                          fontSize:20
                        ),

                      ),
                      SizedBox(
                        width: 9,
                      ),  
                     IconButton(
                         onPressed:(){
                           int quantity = model.quantity+1;
                           if(quantity <=10)
                             ShopCubit.get(context).updateCart(model.id, quantity);
                         },
                      icon: Icon(
                         Icons.add,
                       ),
                     ),

                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
