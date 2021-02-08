import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PruebaTextField extends StatelessWidget {
  PruebaTextField({
    this.placeholder,
    this.keyboardType,
    this.isPassword,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.imageRoute,
    this.iconColor,
    this.initialValue,
    this.textCapitalization,
    this.validationText,
    this.autofocus,
    this.maxLength,
    this.title,
    this.textInputFormatters,
    this.prefixWidget,
    this.key,
    this.width,
    this.enabled,
    this.onFieldSubmitted,
    this.suffixText,
    this.isAutocorrectActive = true,
  });

  Key key;
  String placeholder;
  TextInputType keyboardType;
  bool isPassword;
  Function onChanged;
  Function onTap;
  Function onEditingComplete;
  String imageRoute;
  Color iconColor;
  String initialValue;
  TextCapitalization textCapitalization;
  String validationText;
  bool autofocus;
  int maxLength;
  String title;
  List<TextInputFormatter> textInputFormatters;
  Widget prefixWidget;
  double width;
  bool enabled = true;
  Function onFieldSubmitted;
  String suffixText;
  bool isAutocorrectActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title == null
              ? SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text(
                    title,
                  ),
                ),
          Stack(
            children: [
              Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),

                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: prefixWidget == null
                        ? 16
                        : onChanged == null
                            ? 8
                            : 18),
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    prefixWidget ?? const SizedBox.shrink(),
                    Expanded(
                      child: TextFormField(
                        key: key,
                        enabled: enabled,
                        autofocus: autofocus ?? false,
                        keyboardAppearance: Brightness.light,
                        textCapitalization:
                            textCapitalization ?? TextCapitalization.none,
                        autocorrect: isAutocorrectActive,
                        initialValue: initialValue,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          hintText: placeholder,
                          suffixText: suffixText ?? "",
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          disabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                        ),
                        inputFormatters: textInputFormatters ?? [],
                        keyboardType: keyboardType ?? TextInputType.text,
                        obscureText: isPassword ?? false,
                        onChanged: onChanged,
                        onTap: onTap,
                        onEditingComplete: onEditingComplete,
                        onFieldSubmitted: onFieldSubmitted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
