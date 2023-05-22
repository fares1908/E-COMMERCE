import 'package:ShopApp/Lay_out/Cubit/cubit.dart';
import 'package:ShopApp/Shareing/Compounant/compunant.dart';
import 'package:ShopApp/models/CategoryModel.dart';
import 'package:ShopApp/moduls/home_screen.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(


      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildCategory(
            ShopCubit.get(context).categoryModel?.data.data[index]),
        separatorBuilder: (context, index) => dividerWidget(),
        itemCount: ShopCubit.get(context).categoryModel!.data.data.length,
      ),
    );
  }
}

Widget buildCategory(DataModel? model) => Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orangeAccent),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: NetworkImage('${model?.image}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            '${model!.name.toUpperCase()}',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 17),
          ),
        ],
      ),
    );
