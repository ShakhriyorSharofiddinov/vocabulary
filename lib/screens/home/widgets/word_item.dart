// import 'package:flutter/material.dart';
//
// import '../../../models/word.dart';
// import '../../details/details.dart';
// import 'flag_widget.dart';
//
// class WordItem extends StatelessWidget {
//   final Word word;
//   final bool showCity;
//
//   const WordItem(this.word, this.showCity, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => DetailsPage(word),
//         ));
//       },
//       child: Card(
//         elevation: 8,
//         margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//           child: Row(
//             children: [
//               FlagWidget(word.country ?? "Uzbekistan"),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Text(
//                   showCity ? word.city! : word.country ?? "...",
//                   style: const TextStyle(fontSize: 24),
//                 ),
//               ),
//               const Icon(
//                 Icons.chevron_right_outlined,
//                 size: 32,
//                 color: Colors.black38,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
