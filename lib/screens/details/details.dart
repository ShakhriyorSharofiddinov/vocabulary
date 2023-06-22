// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../main_provider.dart';
// import '../../models/word.dart';
// import '../home/widgets/flag_widget.dart';
//
// class DetailsPage extends StatelessWidget {
//   final Word word;
//
//   const DetailsPage(this.word, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(word.country ?? "Topilmadi"),
//       ),
//       body: Consumer<MainProvider>(builder: (context, data, child) {
//         return Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(height: 72),
//                 Text(
//                   data.showCity ? 'Country: ' : "Capital: ",
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   data.showCity ? word.country! : word.city ?? "...",
//                   style: const TextStyle(fontSize: 36),
//                 ),
//                 const SizedBox(height: 24),
//                 FlagWidget(
//                   word.country ?? "Uzbekistan",
//                   imageHeight: 240,
//                   imageWidth: 320,
//                 )
//               ],
//             )
//           ],
//         );
//       }),
//     );
//   }
// }
