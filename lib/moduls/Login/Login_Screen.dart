import 'package:ShopApp/Lay_out/Cubit/cubit.dart';
import 'package:ShopApp/Lay_out/home_layout.dart';
import 'package:ShopApp/Shareing/Compounant/compunant.dart';
import 'package:ShopApp/Shareing/constant/constant.dart';
import 'package:ShopApp/moduls/Email_Verification.dart';
import 'package:ShopApp/moduls/Login/cubit/cubit.dart';
import 'package:ShopApp/moduls/Login/cubit/states.dart';
import 'package:ShopApp/moduls/Register_Screen.dart';
import 'package:ShopApp/network/network.local.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isPasswordShow = true;

  var formKey = GlobalKey<FormState>();

  @override
  void navigatAndfinshed(context, widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (Route<dynamic> route) => false,
      );

  void navigatTo(context, widget) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){

            if(state.loginModel.status==true){
              showToast(
                  text: (state.loginModel.message)!,
                  state: ToastState.Success

              );
              print(state.loginModel.data!.token);
              print(state.loginModel.message) ;

              CashHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,)
                  .then((value)
              //tokenكل يوزلر بيكون مدخل توكين معين
              {
                token=state.loginModel.data!.token;
                navigatAndfinshed(context, Home_Layout());
              }
              );

            }else{

              showToast(
                text: 'Some Thing Is Wrong',
                state: ToastState.Success

              );
              print(state.loginModel.message);

            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Email Id',
                          style: TextStyle(
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
                              Icons.email_outlined,
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
                            labelText: 'Enter Your Email',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email Address';
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
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        TextFormField(
                          obscureText: isPasswordShow,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outlined,
                              color: Colors.orangeAccent,
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isPasswordShow = !isPasswordShow;
                                });
                              },
                              child: Icon(isPasswordShow
                                  ? Icons.visibility
                                  : Icons.visibility_off),
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
                            labelText: 'Enter Your Password',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Password';
                            } else {
                              return null;
                            }
                          },
                        ),
                        // Row(
                        //   children: [
                        //     Text(""),
                        //     Spacer(),
                        //     MaterialButton(
                        //       onPressed: () {
                        //         navigatAndfinshed(context, EmailVerification());
                        //       },
                        //       child: Text(
                        //         'Forgot Password ?',
                        //         style: TextStyle(
                        //           fontWeight: FontWeight.w300,
                        //           fontSize: 17,
                        //           color: Colors.grey,
                        //           decoration: TextDecoration.underline,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 29,
                        ),
                        Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ConditionalBuilder(
                            builder:(context) =>  MaterialButton(
                              color: Colors.orangeAccent,
                              onPressed: ()async {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  ShopCubit.get(context).getUser();
                                   token=token;

                                }

                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(color: Colors.white),
                              ),
                            ) ,
                            condition: state is! ShopLoginLoadingState,
                            fallback:(context) => Center(child: CircularProgressIndicator(
                              color: Colors.orangeAccent,
                            )),

                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'ARE YOU A NEW USER ?!',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigatTo(context, RegisterScreen());
                              },
                              child: Text(
                                'REGISTER',
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
            ),
          );
        },
      ),
    );
  }
}
