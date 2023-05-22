import 'package:ShopApp/Lay_out/home_layout.dart';
import 'package:ShopApp/Shareing/Compounant/compunant.dart';
import 'package:ShopApp/Shareing/constant/constant.dart';
import 'package:ShopApp/moduls/Login/Login_Screen.dart';
import 'package:ShopApp/moduls/Login/cubit/cubit.dart';
import 'package:ShopApp/moduls/Login/cubit/states.dart';
import 'package:ShopApp/moduls/home_screen.dart';
import 'package:ShopApp/network/network.local.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  void navigatAndfinshed(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false,
  );

  var emailController=TextEditingController();

  var nameController=TextEditingController();

  var phoneController=TextEditingController();

  var passwordController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState){
            if(ShopLoginCubit.get(context).loginModel!.status==true){
              print(state.loginModel.data!.token);
              print(state.loginModel.message) ;
              showToast(
                  text:'${state.loginModel.message}' , state: ToastState.Success
              );
              CashHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token=state.loginModel.data!.token;
                navigatAndfinshed(context,Home_Layout());

              });
            }else{
              showToast(
                text: ('Some Thing Wrong'),
                state: ToastState.Error,

              );
              print(state.loginModel.message);

            }
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style:TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Name',
                        style:TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
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
                          enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.orangeAccent,
                            ),

                          ) ,
                          focusedBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                            ),

                          ) ,
                          labelText: 'Enter Your Name',
                          labelStyle: TextStyle(
                            color:Colors.black,

                          ),

                        ),
                        keyboardType: TextInputType.name,

                        controller: nameController,
                        validator: (value) {

                          if (value!.isEmpty) {
                            return 'Please Enter Your Name';
                          } else {
                            return null;
                          }
                        },

                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Phone Number',
                        style:TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.orangeAccent,
                          ),
                          enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                            ),

                          ) ,
                          focusedBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                            ),

                          ) ,
                          labelText: 'Enter Your Phone',
                          labelStyle: TextStyle(
                            color:Colors.black,

                          ),

                        ),
                        keyboardType: TextInputType.phone,

                        controller: phoneController,
                        validator: (value) {

                          if (value!.isEmpty) {
                            return 'Please Enter Your Phone';
                          } else {
                            return null;
                          }
                        },

                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Email Id',
                        style:TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.orangeAccent,
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                            ),

                          ) ,
                          enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                            ),

                          ) ,
                          labelText:   'Enter Your Email',
                          labelStyle: TextStyle(
                            color:Colors.black,

                          ),


                        ),
                        keyboardType: TextInputType.emailAddress,

                        controller: emailController,
                        validator: (value) {

                          if (value!.isEmpty) {
                            return 'Please Enter Your Email';
                          } else {
                            return null;
                          }
                        },

                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Password',
                        style:TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            color: Colors.orangeAccent,
                          ),

                          enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                            ),

                          ) ,
                          focusedBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                            ),

                          ) ,
                          labelText:   'Enter Your Password',
                          labelStyle: TextStyle(
                            color:Colors.black,

                          ),

                        ),
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        controller: passwordController,
                        validator: (value) {

                          if (value!.isEmpty) {
                            return 'Please Enter Your Password';
                          } else {
                            return null;
                          }
                        },

                      ),
                      SizedBox(
                        height: 20,
                      ),


                      ConditionalBuilder(
                        builder: (context) {
                         return MaterialButton(
                           minWidth: double.infinity,
                           height: 45,

                           color: Colors.orangeAccent,
                           onPressed: (){
                             if(formKey.currentState!.validate()){
                               ShopLoginCubit.get(context).userRegister(
                                   email: emailController.text,
                                   name: nameController.text,
                                   password: passwordController.text,
                                   phone: phoneController.text
                               );
                             }
                           },
                           child: Text(
                             'SING UP',
                             style: TextStyle(
                                 color: Colors.white
                             ),

                           ),

                         );
                        },
                        fallback: (context) => Center(child: CircularProgressIndicator()),
                        condition:state is ! ShopRegisterLoadingState,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'ARE YOU A EXISTING USER ?!',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                            Navigator.pop(context);
                            },
                            child:Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],

                  ),

                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
