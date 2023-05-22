// import 'package:ShopApp/moduls/Login/Login_Screen.dart';
// import 'package:ShopApp/moduls/Register_Screen.dart';
// import 'package:ShopApp/Shareing/Compounant/compunant.dart';
// import 'package:flutter/material.dart';
//
// class NewPassword extends StatelessWidget {
//   @override
//   void navigateAndpush(context, widget) => Navigator.pushAndRemoveUntil(
//     context,
//     MaterialPageRoute(
//       builder: (context) => widget,
//     ),
//         (Route<dynamic> route) => false,
//   );
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//        leading: Icon(
//           Icons.arrow_back_ios,
//           color: Colors.orangeAccent,
//         ),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'ENTER THE NEW PASSWORD',
//                   style:TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.orangeAccent,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 13,
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(
//                       Icons.lock_outlined,
//                       color: Colors.orangeAccent,
//                     ),
//                     enabledBorder:OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide(
//                         color: Colors.orangeAccent,
//                       ),
//
//                     ) ,
//                     focusedBorder:OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide(
//                         color: Colors.orangeAccent,
//                       ),
//
//                     ) ,
//                     labelText:   'Enter Your Password',
//                     labelStyle: TextStyle(
//                       color:Colors.black,
//
//                     ),
//
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   obscureText: true,
//                   controller: TextEditingController(),
//                   validator: (value) {
//                   },
//
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   'Confirm Password',
//                   style:TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(
//                       Icons.lock_outlined,
//                       color: Colors.orangeAccent,
//                     ),
//                     enabledBorder:OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide(
//                         color: Colors.orangeAccent,
//                       ),
//
//                     ) ,
//                     focusedBorder:OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide(
//                         color: Colors.orangeAccent,
//                       ),
//
//                     ) ,
//                     labelText:   'Confirm Your Password',
//                     labelStyle: TextStyle(
//                       color:Colors.black,
//
//                     ),
//
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   obscureText: true,
//                   controller: TextEditingController(),
//                   validator: (value) {
//                   },
//
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//
//                     Spacer(),
//                     FloatingActionButton(
//                       backgroundColor: Colors.orangeAccent,
//                       onPressed: () {
//                         showToast(text: 'Password Successfully Reset', state: ToastState.Success);
//                        navigateTo(context, LoginScreen());
//                         },
//                       child: Icon(
//                           size: 14,
//                           Icons.arrow_forward_ios
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//
//
//             ),
//
//           ),
//         ),
//       ),
//     );
//   }
// }
