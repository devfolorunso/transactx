import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

class AppDropDownField extends StatelessWidget {
  const AppDropDownField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.dropDownItems,
      this.controller,
      this.errorList,
      this.keyboardType,
      required this.validator,
      this.focusNode,
      this.inputFormatters,
      this.onChanged,
      this.enabled,
      this.initialValue,
      this.isRequired = false,
      this.readOnly = false,
      this.onFieldSubmitted,
      this.textInputAction})
      : super(key: key);
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final List<dynamic>? errorList;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool readOnly;
  final bool? isRequired;
  final Function(String)? onFieldSubmitted;
  final String? initialValue;
  final List<String> dropDownItems;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !isRequired!,
          child: Text(
            labelText,
            style: const TextStyle(
              fontSize: 16,
              color: btTextColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.02,
              fontStyle: FontStyle.normal,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Visibility(
          visible: isRequired!,
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.02,
                fontFamily: "Degular",
              ),
              children: <TextSpan>[
                TextSpan(
                    text: labelText,
                    style: const TextStyle(
                      color: btTextColor,
                    )),
                const TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Colors.red,
                    )),
              ],
            ),
          ),
        ),
        gapH4,
        _buildErrorText(errorList),
        gapH8,
        DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSelectedItems: true,
              showSearchBox: true,
            ),

            // selectedItem: ref.watch(createPlanReq).category,
            items: dropDownItems,
            dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    _buildInputDecoration(hintText, errorList)),
            // popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: onChanged,
            validator: validator),
      ],
    );
  }

  Widget _buildErrorText(List<dynamic>? errorList) {
    if (errorList != null && errorList.isNotEmpty) {
      return Text(
        errorList[0].toString(),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.red,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.02,
          fontStyle: FontStyle.normal,
        ),
        textAlign: TextAlign.left,
      );
    } else {
      return const SizedBox();
    }
  }

  InputDecoration _buildInputDecoration(
      String hintText, List<dynamic>? errorList) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: errorList != null ? btSecondaryColor : Colors.grey,
          width: 2.0,
        ),
      ),
      fillColor: btWhite,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2.0),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: btSecondaryColorOne, width: 2.0),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: btv2SecondaryGreetingsIcon, width: 2.0),
      ),
      filled: true,
      hintText: hintText,
      errorStyle: const TextStyle(
        color: btv2SecondaryGreetingsIcon,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
