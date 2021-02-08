import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PruebaButton extends StatelessWidget {
  PruebaButton({
    @required this.onPressed,
    this.title,
    this.backgroundColor,
    this.shadowColor,
    this.isLoading = false,
    this.width,
    this.canPush = false,
    this.withCheck = false,
  });

  String title;
  Color backgroundColor;
  Color shadowColor;
  Function onPressed;
  bool isLoading;
  double width;
  bool canPush;
  bool withCheck;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 48,
          width: width ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue,
          ),
          child: Stack(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child:  Center(
                      child: Text(
                          title ?? "Continuar",
                        style: TextStyle(
                          color: Colors.white
                        ),
                        ),
                    ),
                onPressed: () {
                  if (!isLoading) {
                    onPressed();
                  }
                },
              ),

            ],
          ),
        ),
      ],
    );
  }
}
