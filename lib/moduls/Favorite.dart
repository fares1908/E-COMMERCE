import 'package:ShopApp/Shareing/Compounant/compunant.dart';
import 'package:ShopApp/models/FavoriteModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Lay_out/Cubit/cubit.dart';
import '../Lay_out/Cubit/states.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState(){
    BlocProvider.of<ShopCubit>(context).getFavorite();
    BlocProvider.of<ShopCubit>(context).getCart();
    BlocProvider.of<ShopCubit>(context).getUser();

  }
  
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(

          body: ConditionalBuilder(
            condition: state is! ShopLoadingFavoriteState
        &&ShopCubit.get(context).favorites.length<1,
            fallback: (context) => Center(
                child: CircularProgressIndicator(
                  color: Colors.orangeAccent,
                )),
            builder: (context) {
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildFavorite(
                    ShopCubit.get(context).favoriteModel!.data!.data[index],
                    context),
                separatorBuilder: (context, index) => dividerWidget(),
                itemCount:
                ShopCubit.get(context).favoriteModel!.data!.data.length
              );
            },
          ),
        );
      },
    );
  }
}
Widget buildFavorite(  FavouriteItems model,context ) => Padding(

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
                  imageUrl: '${model.product!.image}',
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
                  '${model.product!.name}',
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
                  '${model.product!.price} EGP',
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

                    ShopCubit.get(context).changFavorite(productId:model.product!.id);
                    // ShopCubit.get(context).changeColor(ShopCubit.get(context).productDetailsModel!.productData!.id!);

                    print(model.id);
                  }, icon: Icon(
                Icons.delete,
                color: Colors.orangeAccent,
              )),

            ],
          )
        ],
      ),
    ],
  ),
);
