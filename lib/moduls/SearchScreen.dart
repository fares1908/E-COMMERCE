import 'package:ShopApp/Lay_out/Cubit/cubit.dart';
import 'package:ShopApp/Lay_out/Cubit/states.dart';
import 'package:ShopApp/Shareing/Compounant/compunant.dart';
import 'package:ShopApp/models/SearchModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  @override
  var formKey = GlobalKey<FormState>();
  var textController = TextEditingController();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.orangeAccent,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.orangeAccent,
                          ),
                        ),
                        labelText: 'Enter Your Product',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      controller: textController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Product';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String value) {
                        if (formKey.currentState!.validate()) {
                          ShopCubit.get(context).SearchProduct(text: value);
                        }


                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (state is ShopLoadingSearchState)
                      LinearProgressIndicator(
                        color: Colors.orangeAccent,
                      ),
                    if(state is ShopSuccessSearchState)
                     Expanded(
                       child: ListView.separated(
                           itemBuilder: (context, index) => buildSearch(ShopCubit.get(context).searchModel!.data!.data[index], context),
                           separatorBuilder:(context, index) => dividerWidget(),
                            itemCount:ShopCubit.get(context).searchModel!.data!.data.length
                       ),
                     )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
Widget buildSearch(  Product model,context ) => Padding(

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
                  imageUrl: '${model.image}',
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
                  '${model.name} ',
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
                  '${model.price} EGP',
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
          // SizedBox(
          //   width: 12,
          // ),
          // Column(
          //   children: [
          //     IconButton(
          //         onPressed: (){
          //           ShopCubit.get(context).changFavorite(model.product!.id);
          //           print(model.id);
          //         }, icon: Icon(
          //       Icons.delete,
          //       color: Colors.orangeAccent,
          //     )),
          //
          //   ],
          // )
        ],
      ),
    ],
  ),
);