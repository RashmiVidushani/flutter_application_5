import 'package:flutter/material.dart';
import 'package:flutter_application_5/widgets/size_constants.dart';

Widget errorContainer() {
  return Container(
    clipBehavior: Clip.hardEdge,
    child: Image.asset(
      'assets/img_not_available.jpeg',
      height: Sizes.dimen_200,
      width: Sizes.dimen_200,
    ),
  );
}

Widget chatImage({required String imageSrc, required Function onTap}) {
  return OutlinedButton(
    onPressed: onTap(),
    child: Image.network(
      imageSrc,
      width: Sizes.dimen_200,
      height: Sizes.dimen_200,
      fit: BoxFit.cover,
      loadingBuilder:
          (BuildContext ctx, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(Sizes.dimen_10),
          ),
          width: Sizes.dimen_200,
          height: Sizes.dimen_200,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
              value: loadingProgress.expectedTotalBytes != null &&
                      loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, object, stackTrace) => errorContainer(),
    ),
  );
}

Widget messageBubble(
    {required String chatContent,
    required EdgeInsetsGeometry? margin,
    Color? color,
    Color? textColor}) {
  return Container(
    padding: const EdgeInsets.all(Sizes.dimen_10),
    margin: margin,
    width: Sizes.dimen_200,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(Sizes.dimen_10),
    ),
    child: Text(
      chatContent,
      style: TextStyle(fontSize: Sizes.dimen_16, color: textColor),
    ),
  );
}
