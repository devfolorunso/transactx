import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

/// @param onPressed - callback to be called when the button is pressed.
/// @parm isPrimary - if true, the button will be styled as a primary button.
/// @parm btnTextFontSize - font size of the button text.
/// @parm btnText - text to display on the button.
/// @parm isLoading - if true, a loading indicator will be displayed instead of
/// the text.
class Aoo  extends StatelessWidget {
  const Aoo (
      {Key? key,
      this.isLoading = false,
      required this.onPressed,
      required this.isPrimary,
      required this.btnText,
      required this.btnTextFontSize,
      required this.btnHeight,
      required this.btColor})
      : super(key: key);
  final bool isLoading;
  final VoidCallback onPressed;
  final bool isPrimary;
  final String btnText;
  final double btnTextFontSize;
  final double btnHeight;
  final Color btColor;
  @override
  Widget build(BuildContext context) {
    // return Platform.isIOS
    //     ? builIOSButton(onPressed, isPrimary, btnText, btnTextFontSize,
    //         isLoading, btnHeight)
    //     : buildAndroidButton(onPressed, isPrimary, btnText, btnTextFontSize,
    //         isLoading, btnHeight);

    return buildAndroidButton(onPressed, isPrimary, btnText, btnTextFontSize,
        isLoading, btnHeight, btColor, context);
  }
}

Widget builIOSButton(VoidCallback? onPressed, bool isPrimary, String btnText,
        double btnTextFontSize, bool isLoading, double btnHeight) =>
    CupertinoButton(
        minSize: btnHeight,
        onPressed: isLoading
            ? null
            : () {
                onPressed!();
              },
        color: isPrimary ? btButtonPrimary : btWhite,
        borderRadius: BorderRadius.circular(5),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                btnText,
                style: TextStyle(
                  fontSize: btnTextFontSize,
                  fontWeight: FontWeight.w600,
                  color: isPrimary ? btWhite : btButtonPrimary,
                ),
                textAlign: TextAlign.center,
              ));

Widget buildAndroidButton(
        VoidCallback? onPressed,
        bool isPrimary,
        String btnText,
        double btnTextFontSize,
        bool isLoading,
        double btnHeight,
        Color btColor,
        BuildContext context) =>
    ElevatedButton(
        onPressed: isLoading
            ? null
            : () {
                onPressed!();
              },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 00),
          fixedSize: Size(MediaQuery.of(context).size.width, btnHeight),
          // backgroundColor: isPrimary ? btButtonPrimary : btWhite,
          backgroundColor: btColor,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                btnText,
                style: TextStyle(
                    fontSize: btnTextFontSize,
                    fontWeight: FontWeight.w600,
                    color: isPrimary ? btWhite : btButtonPrimary),
                textAlign: TextAlign.center,
              ));
