import 'package:ShopApp/Lay_out/Cubit/states.dart';
import 'package:ShopApp/Shareing/Compounant/compunant.dart';
import 'package:ShopApp/Shareing/constant/constant.dart';
import 'package:ShopApp/moduls/Login/Login_Screen.dart';
import 'package:ShopApp/moduls/Login/cubit/cubit.dart';
import 'package:ShopApp/moduls/Login/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Lay_out/Cubit/cubit.dart';

class UserScreen extends StatefulWidget {
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  void navigatAndfinshed(context, widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (Route<dynamic> route) => false,
      );
  bool isLoading = false;
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var PhoneController = TextEditingController();

  var emailController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<ShopCubit>(context).getUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {
          if(state is ShopSuccessUpdateUserState){
            showToast(
                text: 'User Information Update Successfully',
                state: ToastState.Success,
            );
          }
          if(state is ShopErrorUpdateUserState){
            showToast(
              text: 'User Information Don\'t Update Successfully',
              state: ToastState.Error,
            );
          }
        },
        builder: (context, state) {
          var model = ShopCubit.get(context).getUserModel;
          if (model != null) {
            nameController.text = model.data.name!;
            PhoneController.text = model.data.phone!;
            emailController.text = model.data.email!;
          }
          return ConditionalBuilder(
            builder: (context) => Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is ShopLoadingUpdateUserState)
                          LinearProgressIndicator(
                            color: Colors.orangeAccent,
                          ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
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
                            labelText: 'NAME',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          // controller: TextEditingController(
                          //   text:
                          //       ShopCubit.get(context).getUserModel?.data.name,
                          // ),
                          controller: nameController,
                          // text: ShopLoginCubit.get(context).loginModel.data.email,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.orangeAccent,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.orangeAccent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.orangeAccent,
                              ),
                            ),
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          // obscureText: true,
                          controller: emailController,
                          validator: (value) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.orangeAccent,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.orangeAccent,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.orangeAccent,
                              ),
                            ),
                            labelText: 'PHONE NUMBER',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          // obscureText: true,
                          controller: PhoneController,
                          validator: (value) {},
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(344),
                          ),
                          child: MaterialButton(
                            color: Colors.orangeAccent,
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              Future.delayed(Duration(seconds: 3), () {
                                // حاجه هتحصل في المستقبل بعد 3 ثواني اللي هو الخروج

                                signOut(context);
                              });
                            },
                            child:
                                isLoading //لو التحميل ب  ترو اعمل بروجريس انديكتور لو لا اظهر اللوج اوت  اللي هو القيمه الديفولت
                                    //
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      )
                                    : Text(
                                        'LOG OUT',
                                        style: TextStyle(color: Colors.white),
                                      ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(344),
                          ),
                          child: MaterialButton(
                            color: Colors.orangeAccent,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).updateUser(
                                  emailUser: emailController.text,
                                  phoneUser: PhoneController.text,
                                  nameUser: nameController.text,
                                );
                              }
                            },
                            child: Text(
                              'UPDATE PROFILE',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            condition: ShopCubit.get(context).getUserModel != null,
            fallback: (context) => Center(child: CircularProgressIndicator(
              color: Colors.orangeAccent,
            )),
          );
        },
      ),
    );
  }
}
