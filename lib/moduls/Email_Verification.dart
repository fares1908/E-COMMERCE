// import 'package:ShopApp/moduls/Register_Screen.dart';
// import 'package:ShopApp/Shareing/Compounant/compunant.dart';
// import 'package:ShopApp/moduls/new_password.dart';
// import 'package:flutter/material.dart';
//
// class EmailVerification extends StatelessWidget {
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
//         title: Icon(
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
//                   'ENTER THE EMAIL ID',
//                   style:TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.orangeAccent,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 13,
//                 ),
//                 Text(
//                   'Enter Your registered email id',
//                   style:TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.orangeAccent,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(
//                       Icons.email_outlined,
//                       color: Colors.orangeAccent,
//                     ),
//                     focusedBorder:OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide(
//                         color: Colors.orangeAccent,
//                       ),
//
//                     ) ,
//                     enabledBorder:OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20),
//                       borderSide: BorderSide(
//                         color: Colors.orangeAccent,
//                       ),
//
//                     ) ,
//                     labelText:   'Enter Your Email Id',
//                     labelStyle: TextStyle(
//                       color:Colors.black,
//
//                     ),
//
//
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//
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
//                             navigateTo(context,NewPassword ());
//                       },
//                       child: Icon(
//                         size: 14,
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
