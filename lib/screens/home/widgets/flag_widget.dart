import 'package:flutter/material.dart';

class FlagWidget extends StatelessWidget {
  final String country;
  final double? imageHeight;
  final double? imageWidth;

  const FlagWidget(
    this.country, {
    Key? key,
    this.imageHeight = 60,
    this.imageWidth = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.blue,
      elevation: 6,
      child: Image.network(
        "https://www.countries-ofthe-world.com/flags-normal/flag-of-$country.png",
        height: imageHeight,
        width: imageWidth,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return Container(height: imageHeight, width: imageWidth);
        },
      ),
    );
  }
}
